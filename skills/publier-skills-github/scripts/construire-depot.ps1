# Contrôle et prépare un dépôt de skills avant publication. N'envoie rien en ligne.
# - vérifie chaque skills/<nom>/SKILL.md (frontmatter, nom, description, README)
# - met à jour la liste des skills dans .claude-plugin/marketplace.json
# - fabrique dist/<nom>.zip, prêt à importer dans l'application Claude
# Usage : powershell -ExecutionPolicy Bypass -File construire-depot.ps1 -Depot <racine-du-depot> [-SansZip]
param([Parameter(Mandatory = $true)][string]$Depot, [switch]$SansZip)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
$racine = (Resolve-Path -LiteralPath $Depot).Path
$dossierSkills = Join-Path $racine 'skills'
if (-not (Test-Path $dossierSkills)) { Write-Error "Pas de dossier skills/ dans $racine"; exit 3 }

$erreurs = 0; $avert = 0; $noms = @()
"== Contrôle des skills =="
foreach ($d in Get-ChildItem $dossierSkills -Directory | Sort-Object Name) {
  $skill = Join-Path $d.FullName 'SKILL.md'
  $pb = @()
  if (-not (Test-Path $skill)) { "  [ERREUR] $($d.Name) : SKILL.md manquant"; $erreurs++; continue }
  $t = [IO.File]::ReadAllText($skill, [Text.Encoding]::UTF8)
  $m = [regex]::Match($t, '^\uFEFF?---\s*\r?\n([\s\S]*?)\r?\n---')
  if (-not $m.Success) { $pb += 'ERREUR: frontmatter --- absent en tête' }
  else {
    $fm = $m.Groups[1].Value
    $nom = ([regex]::Match($fm, '(?m)^name:\s*"?([^"\r\n]+)"?')).Groups[1].Value.Trim()
    $desc = ([regex]::Match($fm, '(?m)^description:\s*"?([^\r\n]+?)"?\s*$')).Groups[1].Value.Trim()
    if (-not $nom) { $pb += 'ERREUR: name absent' }
    elseif ($nom -ne $d.Name) { $pb += "ERREUR: name '$nom' différent du dossier '$($d.Name)'" }
    elseif ($nom -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$') { $pb += "ERREUR: name '$nom' doit être en minuscules avec tirets" }
    elseif ($nom.Length -gt 64) { $pb += 'ERREUR: name de plus de 64 caractères' }
    if (-not $desc) { $pb += 'ERREUR: description absente' }
    elseif ($desc.Length -gt 1024) { $pb += "ERREUR: description de $($desc.Length) caractères (max 1024)" }
    elseif ($desc.Length -lt 60) { $pb += 'AVERT: description courte, Claude risque de ne pas savoir quand l''utiliser' }
  }
  if (-not (Test-Path (Join-Path $d.FullName 'README.md'))) { $pb += 'AVERT: README.md absent' }
  if ($t -match '[—–]') { $pb += 'AVERT: tiret cadratin ou demi-cadratin dans SKILL.md' }
  foreach ($ref in [regex]::Matches($t, '`((scripts|reference|templates)/[^`\s]+)`')) {
    $chemin = Join-Path $d.FullName ($ref.Groups[1].Value -replace '/', '\')
    if (-not (Test-Path $chemin) -and $ref.Groups[1].Value -notmatch '[<*]') { $pb += "AVERT: fichier cité introuvable : $($ref.Groups[1].Value)" }
  }
  $e = @($pb | Where-Object { $_ -like 'ERREUR*' }).Count; $w = @($pb | Where-Object { $_ -like 'AVERT*' }).Count
  $erreurs += $e; $avert += $w
  $etat = if ($e) { 'ERREUR' } elseif ($w) { 'avert.' } else { 'ok' }
  "  [{0,-6}] {1}" -f $etat, $d.Name
  $pb | ForEach-Object { "           $_" }
  if (-not $e) { $noms += $d.Name }
}

# marketplace.json : la liste des skills suit le contenu du dossier
$mp = Join-Path $racine '.claude-plugin\marketplace.json'
if (Test-Path $mp) {
  $brut = [IO.File]::ReadAllText($mp, [Text.Encoding]::UTF8)
  $null = $brut | ConvertFrom-Json   # s'arrête si le JSON est invalide
  $liste = ($noms | ForEach-Object { "        `"./skills/$_`"" }) -join ",`n"
  # Remplace seulement le tableau "skills" pour garder la mise en forme du fichier
  $brut = [regex]::Replace($brut, '("skills"\s*:\s*\[)[\s\S]*?(\])', { param($x) $x.Groups[1].Value + "`n" + $liste + "`n      " + $x.Groups[2].Value }, 1)
  $null = $brut | ConvertFrom-Json
  [IO.File]::WriteAllText($mp, $brut, (New-Object Text.UTF8Encoding $false))
  "== marketplace.json : $($noms.Count) skills listés =="
} else { "== marketplace.json absent : créez .claude-plugin/marketplace.json (modèle dans templates/) ==" }

if (-not $SansZip) {
  $dist = Join-Path $racine 'dist'
  New-Item -ItemType Directory -Force $dist | Out-Null
  foreach ($n in $noms) {
    $zip = Join-Path $dist "$n.zip"
    if (Test-Path $zip) { Remove-Item -LiteralPath $zip -Force }
    $src = Join-Path $dossierSkills $n
    $z = [IO.Compression.ZipFile]::Open($zip, 'Create')
    foreach ($f in Get-ChildItem $src -Recurse -File) {
      $entree = $n + '/' + ($f.FullName.Substring($src.Length + 1) -replace '\\', '/')
      [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($z, $f.FullName, $entree, 'Optimal') | Out-Null
    }
    $z.Dispose()
  }
  "== dist/ : $($noms.Count) ZIP prêts à importer dans l'application Claude =="
}
"== Bilan : $erreurs erreur(s), $avert avertissement(s) =="
exit $(if ($erreurs) { 1 } else { 0 })
