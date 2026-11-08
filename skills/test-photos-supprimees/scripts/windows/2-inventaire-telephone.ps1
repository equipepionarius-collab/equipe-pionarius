# Compte les fichiers visibles sur le téléphone par dossier, type et année. Ne copie rien.
$shell = New-Object -ComObject Shell.Application
$devices = $shell.NameSpace(17).Items() | Where-Object { $_.Name -notmatch '\([A-Z]:\)' -and $_.Type -notmatch 'disque|disk|Lecteur|Drive' }
if (-not $devices) { "Aucun téléphone accessible. Lancez d'abord 1-detecter-telephone.ps1."; exit 2 }

$types = @{}; $years = @{}; $total = 0; $thumbs = 0

function Walk($folder, $path, $depth) {
  foreach ($it in @($folder.Items())) {
    if ($it.IsFolder) {
      if ($depth -lt 4) {
        $sub = $it.GetFolder
        $count = @($sub.Items()).Count
        if ($it.Name -eq '.thumbnails') { $script:thumbs += $count; "  ! Dossier de miniatures Android : $path/$($it.Name) ($count éléments)" }
        Walk $sub "$path/$($it.Name)" ($depth + 1)
      }
    } else {
      $script:total++
      $e = [IO.Path]::GetExtension($it.Name).ToUpper().TrimStart('.')
      if (-not $e) { $e = ($it.Type -replace '^Fichier ', '') }
      $script:types[$e] = 1 + $script:types[$e]
      $y = $null
      if ($path -match '/(\d{4})\d{2}_[a-z]') { $y = $Matches[1] }
      elseif ($it.ModifyDate) { $y = ([datetime]$it.ModifyDate).Year }
      if ($y) { $script:years["$y"] = 1 + $script:years["$y"] }
    }
  }
}

foreach ($d in $devices) { "== $($d.Name) =="; Walk $d.GetFolder $d.Name 0 }

"== Total : $total fichiers visibles =="
"-- Par type --"
$types.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object { "  {0,-6} {1}" -f $_.Key, $_.Value }
"-- Par année --"
$years.GetEnumerator() | Sort-Object Key | ForEach-Object { "  {0}  {1}" -f $_.Key, $_.Value }
if ($thumbs) { "-- Miniatures Android trouvées : $thumbs (aperçus, pas les originaux) --" }
