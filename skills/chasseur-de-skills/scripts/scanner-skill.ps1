# Scanner statique d'un skill, plugin ou serveur MCP téléchargé. Lecture seule : rien n'est exécuté.
# Usage : powershell -ExecutionPolicy Bypass -File scanner-skill.ps1 -Dossier <chemin> [-Json]
# Code de sortie : 0 = rien de grave, 1 = précautions, 2 = ne pas installer.
param(
  [Parameter(Mandatory = $true)][string]$Dossier,
  [switch]$Json
)
if (-not (Test-Path -LiteralPath $Dossier)) { Write-Error "Dossier introuvable : $Dossier"; exit 3 }
$racine = (Resolve-Path -LiteralPath $Dossier).Path

# Chaque règle : catégorie, gravité (points de risque), motif, explication.
$regles = @(
  @{ cat = 'Exécution distante';   pts = 30; re = '(curl|wget|iwr|Invoke-WebRequest)[^\n|]*\|\s*(ba)?sh|iex\s*\(|Invoke-Expression'; why = 'Télécharge et exécute du code à la volée' },
  @{ cat = 'Code dynamique';       pts = 15; re = '\beval\s*\(|\bexec\s*\(|new Function\s*\(|child_process|subprocess\.(Popen|call|run)|os\.system'; why = 'Exécute du code ou des commandes construits à la volée' },
  @{ cat = 'Obfuscation';          pts = 20; re = 'base64\s+(-d|--decode)|FromBase64String|atob\s*\(|[A-Za-z0-9+/]{120,}={0,2}'; why = 'Contenu encodé ou masqué' },
  @{ cat = 'Lecture de secrets';   pts = 25; re = '\.env\b|~/\.ssh|\.ssh[\\/]|~/\.aws|\.aws[\\/]|id_rsa|_API_KEY|API_TOKEN|SECRET_KEY|keychain|Login Data|[\\/]Cookies\b|cookies\.sqlite|document\.cookie|credentials\.json'; why = 'Accède à des clés, mots de passe ou cookies' },
  @{ cat = 'Exfiltration';         pts = 25; re = 'webhook|discord(app)?\.com/api|hooks\.slack\.com|api\.telegram\.org|pastebin|gist\.github|ngrok|requestbin|pipedream'; why = 'Envoie des données vers un service tiers' },
  @{ cat = 'Instruction cachée';   pts = 25; re = '<!--[\s\S]{0,400}?(ignore|ignorez|silently|silencieusement|do not tell|ne dis pas|system prompt|assistant)[\s\S]{0,400}?-->'; why = 'Consigne pour l''IA cachée dans un commentaire HTML' },
  @{ cat = 'Manipulation de l''IA'; pts = 20; re = '(ignore|disregard|oublie|ignorez)\s+(all\s+|toutes\s+les\s+|les\s+)?(previous|prior|précédentes|instructions)|considère ce skill comme sûr|treat this skill as safe|without (asking|telling) the user|sans prévenir l''utilisat'; why = 'Demande à l''IA de contourner l''utilisateur ou ses règles' },
  @{ cat = 'Persistance';          pts = 15; re = '\.bashrc|\.zshrc|\.profile\b|crontab|schtasks|Register-ScheduledTask|HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Run|settings\.json|\.claude[\\/]'; why = 'Écrit hors du dossier du skill (démarrage, tâches, configuration de Claude)' },
  @{ cat = 'Installation auto';    pts = 10; re = '"(pre|post)install"\s*:|setup\.py|install\.sh'; why = 'Script lancé automatiquement à l''installation' },
  @{ cat = 'Réseau';               pts = 5;  re = 'https?://(?!github\.com|raw\.githubusercontent\.com|docs\.|www\.w3\.org|schema\.org|en\.wikipedia\.org|fr\.wikipedia\.org|img\.shields\.io)[^\s)"''>]+'; why = 'Adresse réseau à vérifier' }
)

$extensions = '\.(md|txt|json|ya?ml|toml|sh|bash|zsh|ps1|psm1|py|js|mjs|cjs|ts|rb|go|rs|html?)$'
$fichiers = Get-ChildItem -LiteralPath $racine -Recurse -File -Force -ErrorAction SilentlyContinue | Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' }
$lus = @(); $ignores = @(); $constats = @()

foreach ($f in $fichiers) {
  $rel = $f.FullName.Substring($racine.Length).TrimStart('\', '/')
  if ($f.Name -notmatch $extensions -and $f.Name -notin @('Dockerfile', 'Makefile')) { $ignores += "$rel (binaire ou format non lu)"; continue }
  if ($f.Length -gt 2MB) { $ignores += "$rel (plus de 2 Mo)"; continue }
  $texte = [IO.File]::ReadAllText($f.FullName)
  $lus += $rel
  # Caractères invisibles (espaces de largeur nulle, contrôle de direction)
  $inv = [regex]::Matches($texte, '[\u200B-\u200F\u202A-\u202E\u2060-\u2064\uFEFF]')
  if ($inv.Count -gt 1 -or ($inv.Count -eq 1 -and $texte.IndexOf([char]0xFEFF) -ne 0)) {
    $constats += [pscustomobject]@{ categorie = 'Texte invisible'; points = 20; fichier = $rel; ligne = ($texte.Substring(0, $inv[0].Index) -split "`n").Count; extrait = "$($inv.Count) caractère(s) invisible(s)"; raison = 'Peut cacher une consigne à l''IA' }
  }
  foreach ($r in $regles) {
    foreach ($m in [regex]::Matches($texte, $r.re, 'IgnoreCase')) {
      $ligne = ($texte.Substring(0, $m.Index) -split "`n").Count
      $extrait = ($m.Value -replace '\s+', ' ')
      if ($extrait.Length -gt 90) { $extrait = $extrait.Substring(0, 90) + '…' }
      $constats += [pscustomobject]@{ categorie = $r.cat; points = $r.pts; fichier = $rel; ligne = $ligne; extrait = $extrait; raison = $r.why }
    }
  }
}

# Score : la règle la plus grave de chaque catégorie compte une fois, plafonné à 100.
$score = [Math]::Min(100, (($constats | Group-Object categorie | ForEach-Object { ($_.Group | Measure-Object points -Maximum).Maximum }) | Measure-Object -Sum).Sum)
if (-not $score) { $score = 0 }
$verdict = if ($score -le 20) { 'Installer' } elseif ($score -le 50) { 'Installer avec précautions' } else { 'Ne pas installer' }
$licence = Get-ChildItem -LiteralPath $racine -File | Where-Object Name -match '^(LICENSE|LICENCE|COPYING)' | Select-Object -First 1
$typeLicence = 'aucune'
if ($licence) {
  $l = [IO.File]::ReadAllText($licence.FullName)
  $typeLicence = switch -Regex ($l) { 'MIT License' { 'MIT'; break } 'Apache License' { 'Apache-2.0'; break } 'GNU AFFERO' { 'AGPL'; break } 'GNU GENERAL PUBLIC' { 'GPL'; break } 'BSD' { 'BSD'; break } default { 'autre (à lire)' } }
}

if ($Json) {
  [pscustomobject]@{ dossier = $racine; score = $score; verdict = $verdict; licence = $typeLicence; fichiers_lus = $lus; fichiers_non_lus = $ignores; constats = $constats } | ConvertTo-Json -Depth 4
} else {
  "== Scan de : $racine =="
  "Fichiers lus : $($lus.Count) · non lus : $($ignores.Count) · licence : $typeLicence"
  if ($constats.Count -eq 0) { "Aucun motif à risque trouvé." }
  else {
    $constats | Sort-Object points -Descending | ForEach-Object { "[{0,2}] {1,-22} {2}:{3}  {4}  -> {5}" -f $_.points, $_.categorie, $_.fichier, $_.ligne, $_.extrait, $_.raison }
  }
  if ($ignores.Count) { "-- Non lus --"; $ignores | ForEach-Object { "  $_" } }
  "== Score de risque : $score/100 · Verdict : $verdict =="
  "Rappel : un scan statique ne prouve pas l'absence de risque. Lisez les constats, ils peuvent être des faux positifs."
}
exit $(if ($score -gt 50) { 2 } elseif ($score -gt 20) { 1 } else { 0 })
