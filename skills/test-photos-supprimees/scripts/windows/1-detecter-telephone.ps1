# Détecte un téléphone branché en USB et dit si son stockage est accessible. Lecture seule.
$ErrorActionPreference = 'SilentlyContinue'
$usb = Get-PnpDevice -PresentOnly | Where-Object { $_.FriendlyName -match 'iPhone|iPad|Apple Mobile|Android|Pixel|Galaxy|Samsung|Xiaomi|Redmi|OnePlus|Huawei|Oppo|Motorola|MTP' }
"== Appareils USB détectés =="
if ($usb) { $usb | ForEach-Object { "  [{0}] {1} ({2})" -f $_.Class, $_.FriendlyName, $_.Status } } else { "  Aucun téléphone détecté." }

$apple = $usb | Where-Object FriendlyName -match 'Apple|iPhone|iPad'
if ($apple) {
  $app = Get-AppxPackage | Where-Object Name -like 'AppleInc.AppleDevices*' | Select-Object -First 1
  $svc = (Get-Service | Where-Object DisplayName -match 'Apple Mobile Device') -or (Get-Process | Where-Object Name -match 'AppleMobileDevice')
  if ($app) { "  Appareils Apple : installée ($($app.Version))" }
  elseif ($svc) { "  Service Apple Mobile Device : présent" }
  else { "  Aucun logiciel Apple. Si le stockage reste vide, installez 'Appareils Apple' (Microsoft Store)." }
}

"== Stockage visible dans l'Explorateur =="
$shell = New-Object -ComObject Shell.Application
$devices = $shell.NameSpace(17).Items() | Where-Object { $_.Type -notmatch 'disque|disk|Lecteur|Drive' -and $_.Name -notmatch '^[A-Z]:' -and $_.Name -notmatch '\([A-Z]:\)' }
if (-not $devices) { "  Aucun appareil mobile dans 'Ce PC'. Déverrouillez le téléphone, acceptez l'accès, ou changez de câble."; exit 2 }
foreach ($d in $devices) {
  $roots = @($d.GetFolder.Items())
  "  {0} : {1} dossier(s) racine" -f $d.Name, $roots.Count
  if ($roots.Count -eq 0) { "    -> Stockage fermé : appuyez sur 'Se fier' (iPhone) ou 'Transfert de fichiers' (Android)."; continue }
  foreach ($r in $roots) {
    $n = @($r.GetFolder.Items()).Count
    "    {0} : {1} élément(s)" -f $r.Name, $n
    if ($n -eq 0) { "    -> Vide : le téléphone est sans doute verrouillé ou n'a pas autorisé l'accès." }
  }
}
