# Faire le test sur Mac

Les scripts PowerShell sont pour Windows. Sur Mac, les mêmes vérifications se font avec ces commandes (lecture seule).

## 1. Détecter le téléphone

```bash
system_profiler SPUSBDataType | grep -iE "iphone|ipad|android|pixel|galaxy|samsung" -A3
```

- iPhone : ouvrir le Finder, cliquer sur l'iPhone dans la barre latérale, puis **Se fier** sur le téléphone.
- Android : installer « Android File Transfer » ou utiliser `adb` (options développeur → Débogage USB).

## 2. Inventorier

- iPhone : ouvrir **Transfert d'images** (Image Capture) ; le nombre d'éléments s'affiche en bas.
- Android avec adb :

```bash
adb shell "ls -R /sdcard/DCIM | wc -l"
adb shell "ls /sdcard/DCIM/.thumbnails | wc -l"
```

Le dossier `.thumbnails` est celui du témoignage viral.

## 3. Chercher les copies sur le Mac

```bash
ls ~/Library/Application\ Support/MobileSync/Backup 2>/dev/null
du -sh ~/Pictures/Photos\ Library.photoslibrary 2>/dev/null
```

Dans l'app Photos : **Supprimés récemment** et **Importations**.

## 4. Cache d'aperçus du Mac

macOS garde des aperçus Quick Look dans le dossier renvoyé par :

```bash
echo $(getconf DARWIN_USER_CACHE_DIR)com.apple.QuickLook.thumbnailcache
```

Pour le vider : `qlmanage -r cache` (sans risque, macOS le recrée).
