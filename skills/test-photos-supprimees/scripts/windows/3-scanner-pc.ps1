# Cherche sur le PC les copies et traces de photos : sauvegardes, cloud, corbeille, cache de miniatures. Lecture seule.
$media = '\.(jpe?g|heic|png|gif|webp|mov|mp4|avi|3gp)$'
$places = [ordered]@{
  'Sauvegardes iPhone (iTunes)'          = "$env:APPDATA\Apple Computer\MobileSync\Backup"
  'Sauvegardes iPhone (Appareils Apple)' = "$env:USERPROFILE\Apple\MobileSync\Backup"
  'Sauvegardes iPhone (Store)'           = "$env:LOCALAPPDATA\Packages\AppleInc.AppleDevices_nzyj5cx40ttqa\LocalCache\Roaming\Apple Computer\MobileSync\Backup"
  'iCloud Photos'                        = "$env:USERPROFILE\Pictures\iCloud Photos"
  'iCloud Drive'                         = "$env:USERPROFILE\iCloudDrive"
  'Images'                               = "$env:USERPROFILE\Pictures"
  'OneDrive Images'                      = "$env:USERPROFILE\OneDrive\Pictures"
  'OneDrive Images (fr)'                 = "$env:USERPROFILE\OneDrive\Images"
  'Google Drive'                         = "$env:USERPROFILE\Google Drive"
  'Téléchargements'                      = "$env:USERPROFILE\Downloads"
}
"== Copies sur le PC =="
foreach ($k in $places.Keys) {
  $p = $places[$k]
  if (-not (Test-Path $p)) { "  {0,-38} absent" -f $k; continue }
  $files = Get-ChildItem $p -Recurse -File -ErrorAction SilentlyContinue
  if ($k -like 'Sauvegardes*') {
    $dirs = @(Get-ChildItem $p -Directory -ErrorAction SilentlyContinue)
    "  {0,-38} {1} sauvegarde(s), {2:N1} Go" -f $k, $dirs.Count, (($files | Measure-Object Length -Sum).Sum / 1GB)
  } else {
    $m = @($files | Where-Object Name -match $media)
    $range = ''
    if ($m.Count) { $s = $m | Sort-Object LastWriteTime; $range = " ({0:yyyy-MM} -> {1:yyyy-MM})" -f $s[0].LastWriteTime, $s[-1].LastWriteTime }
    "  {0,-38} {1} photo(s)/vidéo(s){2}" -f $k, $m.Count, $range
  }
}

"== Corbeille Windows =="
$rb = @((New-Object -ComObject Shell.Application).NameSpace(10).Items())
$rbm = @($rb | Where-Object { $_.Name -match $media })
"  {0} élément(s), dont {1} photo(s)/vidéo(s)" -f $rb.Count, $rbm.Count

"== Cache de miniatures Windows =="
$tc = Get-ChildItem "$env:LOCALAPPDATA\Microsoft\Windows\Explorer" -Filter 'thumbcache_*.db' -ErrorAction SilentlyContinue
"  {0} fichier(s), {1:N1} Mo au total" -f @($tc).Count, (($tc | Measure-Object Length -Sum).Sum / 1MB)
"  Ce cache garde des aperçus d'images déjà affichées, même supprimées depuis."
"  Pour le vider : cleanmgr -> cocher 'Miniatures'."
