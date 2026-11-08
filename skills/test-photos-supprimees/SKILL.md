---
name: test-photos-supprimees
description: Vérifie ce qu'un ordinateur peut voir d'un téléphone branché en USB (iPhone ou Android) et cherche les traces de photos supprimées (pellicule, sauvegardes, cloud, corbeille, cache de miniatures). À utiliser quand la personne demande de « faire le test des photos supprimées », de retrouver des photos effacées sur son téléphone, ou de vérifier quelles traces d'images son ordinateur garde.
---

# Test des photos supprimées

Ce skill reproduit, de façon honnête et vérifiable, le test viral « 214 856 photos supprimées retrouvées grâce à l'IA ». Il dit ce que l'ordinateur voit vraiment, sans rien promettre de plus.

## Règles à respecter pendant tout le test

- **Lecture seule.** Les scripts ne modifient, ne copient et ne suppriment rien, sauf l'extraction de miniatures (étape 5), qui demande l'accord explicite de la personne.
- **Rien ne quitte l'ordinateur.** Ne jamais envoyer d'image, de miniature ou de liste de noms de fichiers à un service en ligne, par e-mail ou dans un artefact publié. Le rapport contient seulement des chiffres.
- **Jamais de suppression définitive.** Pour faire le ménage, mettre à la corbeille ou indiquer à la personne l'outil à utiliser (Nettoyage de disque, « Supprimés récemment »).
- **Ne pas ouvrir les images extraites** sans que la personne le demande : elles peuvent contenir des papiers d'identité ou des données bancaires.
- Parler simplement, en français, et dire clairement ce qui n'a pas pu être vérifié.

## Déroulé

Les scripts sont dans `scripts/windows/` (PowerShell). Sur Mac, suivre `reference/mac.md`. Lancer chaque script avec `powershell -ExecutionPolicy Bypass -File <script>`.

### 1. Détecter le téléphone

Lancer `scripts/windows/1-detecter-telephone.ps1`.

- Aucun téléphone → demander de brancher le câble, de déverrouiller le téléphone et de garder l'écran allumé.
- Téléphone détecté mais **aucun dossier** ou dossier « Internal Storage » vide :
  1. iPhone : appuyer sur **Se fier** et taper le code.
  2. iPhone sur Windows : si le stockage reste vide, installer l'application **Appareils Apple** (Microsoft Store) ; le script signale son absence. Elle n'est pas toujours nécessaire.
  3. Android : choisir **Transfert de fichiers** dans la notification USB.
  4. Si le téléphone apparaît puis disparaît, c'est presque toujours le **câble** ou le **port** : changer de câble (d'origine ou certifié) et brancher sans hub.
- Relancer le script après chaque correction. Ne pas boucler plus de 3 fois sans repasser la main à la personne.

### 2. Inventorier ce que l'ordinateur voit

Lancer `scripts/windows/2-inventaire-telephone.ps1`. Il compte les fichiers par dossier, par type et par année, sans rien copier.

À expliquer :
- **iPhone** : on ne voit que la pellicule actuelle (dossiers `AAAAMM_a`). Les photos supprimées n'y sont jamais.
- **Android** : signaler un éventuel dossier `.thumbnails` et son nombre de fichiers. C'est l'origine du témoignage viral : ce sont des aperçus, pas les originaux.
- Une année presque vide veut dire que les photos ont été supprimées **ou** qu'elles ne sont que dans le cloud (iCloud « Optimiser le stockage », Google Photos).

### 3. Chercher les copies sur l'ordinateur

Lancer `scripts/windows/3-scanner-pc.ps1`. Il cherche les sauvegardes de téléphone, iCloud Photos, OneDrive et Google Drive, compte les médias dans la corbeille Windows et mesure le cache de miniatures.

### 4. Indiquer les endroits à vérifier à la main

Ces endroits ne sont pas accessibles depuis l'ordinateur ; les donner à la personne :
- iPhone : Photos → Collections → **Supprimés récemment** (30 jours).
- Android : Google Photos → **Corbeille** (30 à 60 jours).
- En ligne : icloud.com → Photos, photos.google.com → Corbeille, corbeille OneDrive.

### 5. Optionnel : extraire les miniatures du cache Windows

Seulement si la personne le demande explicitement, après l'avoir prévenue que le résultat peut contenir des images sensibles.

`scripts/windows/5-extraire-miniatures.ps1 -Sortie <dossier>` copie les aperçus JPEG/PNG du cache dans un dossier local, sans doublons. On ne peut pas savoir de quel fichier vient chaque miniature.

### 6. Rapport et ménage

Faire un rapport court avec un tableau : endroit fouillé · ce qui a été trouvé · fichiers supprimés retrouvés (oui / non / non vérifié).

Proposer ensuite le ménage, sans le faire soi-même de façon définitive :
- dossier d'extraction → corbeille (ou à supprimer par la personne) ;
- cache de miniatures Windows → `cleanmgr` puis cocher **Miniatures** ;
- « Supprimés récemment » → à vider par la personne sur son téléphone.

## Ce que le test a donné chez nous (repère)

iPhone branché à un PC Windows 11 : 862 fichiers visibles, 0 fichier supprimé retrouvé sur le téléphone. Sur le PC, 1 230 miniatures dans le cache de Windows, dont des images supprimées depuis. Il a fallu installer Appareils Apple et changer de câble.
