# Extrait les aperçus JPEG/PNG du cache de miniatures Windows vers un dossier local, sans doublons.
# À lancer uniquement avec l'accord de la personne : le résultat peut contenir des images sensibles.
param([Parameter(Mandatory = $true)][string]$Sortie)
New-Item -ItemType Directory -Force $Sortie | Out-Null
$src = Get-ChildItem "$env:LOCALAPPDATA\Microsoft\Windows\Explorer" -Filter 'thumbcache_*.db' | Where-Object { $_.Length -gt 100KB }
$seen = @{}; $sha = [Security.Cryptography.SHA1]::Create(); $n = 0
foreach ($f in $src) {
  $tmp = Join-Path $env:TEMP ('tc_' + $f.Name)
  try { Copy-Item $f.FullName $tmp -Force -ErrorAction Stop } catch { "  ignoré : $($f.Name) (verrouillé)"; continue }
  $b = [IO.File]::ReadAllBytes($tmp); Remove-Item $tmp -Force
  $size = $f.BaseName -replace 'thumbcache_', ''
  $i = 0; $len = $b.Length; $cnt = 0
  while ($i -lt $len - 4) {
    if ($b[$i] -eq 0xFF -and $b[$i + 1] -eq 0xD8 -and $b[$i + 2] -eq 0xFF) {
      $j = $i + 3; while ($j -lt $len - 1 -and -not ($b[$j] -eq 0xFF -and $b[$j + 1] -eq 0xD9)) { $j++ }
      $end = $j + 2; $ext = 'jpg'
    } elseif ($b[$i] -eq 0x89 -and $b[$i + 1] -eq 0x50 -and $b[$i + 2] -eq 0x4E -and $b[$i + 3] -eq 0x47) {
      $j = $i + 4; while ($j -lt $len - 8 -and -not ($b[$j] -eq 0x49 -and $b[$j + 1] -eq 0x45 -and $b[$j + 2] -eq 0x4E -and $b[$j + 3] -eq 0x44)) { $j++ }
      $end = $j + 8; $ext = 'png'
    } else { $i++; continue }
    $l = $end - $i
    if ($l -gt 2000 -and $end -le $len) {
      $chunk = New-Object byte[] $l; [Array]::Copy($b, $i, $chunk, 0, $l)
      $h = [BitConverter]::ToString($sha.ComputeHash($chunk))
      if (-not $seen[$h]) { $seen[$h] = 1; $n++; $cnt++; [IO.File]::WriteAllBytes((Join-Path $Sortie ('{0}_{1:D5}.{2}' -f $size, $n, $ext)), $chunk) }
    }
    $i = $end
  }
  "  {0} : {1} miniature(s)" -f $f.Name, $cnt
}
"TOTAL : $n miniature(s) unique(s) dans $Sortie"
"Ménage : mettre ce dossier à la corbeille quand vous avez terminé."
