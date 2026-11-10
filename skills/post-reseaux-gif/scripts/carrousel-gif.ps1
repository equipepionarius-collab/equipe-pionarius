# Fabrique un carrousel animé (GIF en boucle, format portrait 4:5) à partir d'un fichier de diapos JSON.
# Usage : powershell -ExecutionPolicy Bypass -File carrousel-gif.ps1 -Diapos diapos.json -Sortie post.gif [-Apercu dossier]
# Windows uniquement (System.Drawing + WPF, inclus dans Windows). Rien n'est envoyé en ligne.
param(
  [Parameter(Mandatory = $true)][string]$Diapos,
  [Parameter(Mandatory = $true)][string]$Sortie,
  [string]$Apercu
)
$ErrorActionPreference = 'Stop'
$cs = [IO.File]::ReadAllText((Join-Path $PSScriptRoot 'carrousel.cs'), [Text.Encoding]::UTF8)
Add-Type -TypeDefinition $cs -ReferencedAssemblies System.Drawing
Add-Type -AssemblyName PresentationCore, WindowsBase

$cfg = [IO.File]::ReadAllText((Resolve-Path -LiteralPath $Diapos).Path, [Text.Encoding]::UTF8) | ConvertFrom-Json
$th = $cfg.theme
function Val($v, $defaut) { if ($null -eq $v -or $v -eq '') { $defaut } else { $v } }
[Carrousel]::Theme((Val $th.fond '#0F172A'), (Val $th.carte '#1E293B'), (Val $th.texte '#FFFFFF'), (Val $th.secondaire '#94A3B8'), (Val $th.accent '#3B82F6'))
[Carrousel]::Bandeau = [string](Val $cfg.bandeau '')
if ($cfg.police) { [Carrousel]::Police = $cfg.police }
if ($cfg.logo) {
  $lp = $cfg.logo
  if (-not [IO.Path]::IsPathRooted($lp)) { $lp = Join-Path (Split-Path (Resolve-Path -LiteralPath $Diapos).Path) $lp }
  if (Test-Path -LiteralPath $lp) { [Carrousel]::Logo = [Drawing.Image]::FromFile($lp) } else { Write-Warning "Logo introuvable : $lp" }
}
$slides = @($cfg.diapos)
[Carrousel]::Total = $slides.Count
$duree = [int](100 * [double](Val $cfg.duree_secondes 4.5))

for ($i = 0; $i -lt $slides.Count; $i++) {
  $s = $slides[$i]
  $d = if ($s.duree_secondes) { [int](100 * [double]$s.duree_secondes) } else { $duree }
  switch ($s.type) {
    'accroche'    { [Carrousel]::Accroche($i, [string]$s.grand, [string]$s.titre, [string]$s.texte, [string]$s.bas, $d) }
    'chiffre'     { [Carrousel]::Chiffre($i, [string]$s.titre, [double]$s.nombre, [string]$s.legende, [string]$s.nombre2, [string]$s.legende2, [string]$s.note, ($s.anime -ne $false), $d) }
    'liste'       { [Carrousel]::Liste($i, [string]$s.titre, [string]$s.sous_titre, [string[]]@($s.items), ($s.numerote -ne $false), $d) }
    'etapes'      { [Carrousel]::Etapes($i, [string]$s.titre, [string]$s.sous_titre, [string[]]@($s.items | ForEach-Object { $_.texte }), [bool[]]@($s.items | ForEach-Object { [bool]$_.ok }), $d) }
    'barres'      { [Carrousel]::Barres($i, [string]$s.titre, [string]$s.sous_titre, [string[]]@($s.etiquettes), [double[]]@($s.valeurs), [int](Val $s.accent -1), $d) }
    'comparaison' { [Carrousel]::Comparaison($i, [string]$s.titre, [string]$s.colonne_a, [string]$s.colonne_b, [string[]]@($s.lignes | ForEach-Object { $_.critere }), [string[]]@($s.lignes | ForEach-Object { $_.a }), [string[]]@($s.lignes | ForEach-Object { $_.b }), [string]$s.encart, $d) }
    'analyse'     { [Carrousel]::Analyse($i, [string]$s.surtitre, [string]$s.titre, [string]$s.texte, [string]$s.fort, [string[]]@($s.pastilles), $d) }
    'cta'         { [Carrousel]::Cta($i, [string]$s.titre, [string]$s.etape1, [string]$s.etape2, [string]$s.mot_cle, [string]$s.texte, $d) }
    default       { throw "Diapo $($i + 1) : type inconnu '$($s.type)'. Types : accroche, chiffre, liste, etapes, barres, comparaison, analyse, cta." }
  }
}

$enc = New-Object System.Windows.Media.Imaging.GifBitmapEncoder
if ($Apercu) { New-Item -ItemType Directory -Force $Apercu | Out-Null }
$k = 0
foreach ($bmp in [Carrousel]::Images) {
  $ms = New-Object IO.MemoryStream
  $bmp.Save($ms, [Drawing.Imaging.ImageFormat]::Png)
  if ($Apercu -and [Carrousel]::Delais[$k] -gt 100) { $bmp.Save((Join-Path $Apercu ('image-{0:D2}.png' -f $k)), [Drawing.Imaging.ImageFormat]::Png) }
  $ms.Position = 0
  $dec = [System.Windows.Media.Imaging.BitmapDecoder]::Create($ms, 'PreservePixelFormat', 'OnLoad')
  $enc.Frames.Add($dec.Frames[0])
  $k++
}
$brut = New-Object IO.MemoryStream
$enc.Save($brut)
$octets = [Carrousel]::Animer($brut.ToArray(), [int[]][Carrousel]::Delais.ToArray())
$cible = [IO.Path]::GetFullPath($Sortie)
[IO.File]::WriteAllBytes($cible, $octets)
"{0} diapos, {1} images, {2:N1} Mo, {3:N0} s -> {4}" -f $slides.Count, [Carrousel]::Images.Count, ($octets.Length / 1MB), (([Carrousel]::Delais | Measure-Object -Sum).Sum / 100), $cible
if ($octets.Length -gt 5MB) { Write-Warning 'Plus de 5 Mo : réduisez le nombre de diapos ou de diapos animées.' }
