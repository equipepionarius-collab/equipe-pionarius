# test-photos-supprimees

> Vérifier, honnêtement, ce qu'un ordinateur peut voir d'un téléphone branché en USB, et où se cachent vraiment les traces de photos supprimées.

## Pourquoi ce skill

Un témoignage viral affirme qu'un utilisateur a retrouvé 214 856 photos « supprimées » de son Google Pixel grâce à Claude Code. Nous avons refait le test avec un iPhone et un PC Windows 11. Ce skill reprend notre méthode pour que chacun puisse vérifier ses propres appareils, sans promesse exagérée.

| | Témoignage viral | Notre test |
| --- | --- | --- |
| Téléphone | Google Pixel (Android) | iPhone |
| Ordinateur | MacBook | PC Windows 11 |
| Fichiers « cachés » sur le téléphone | Plus de 214 000 miniatures | Aucun : 862 fichiers de la pellicule |
| Images effacées retrouvées | Sur le téléphone | Sur le PC : 1 230 miniatures du cache Windows |

## Ce qu'il fait

1. **Détecte le téléphone** (iPhone ou Android) et diagnostique l'accès : écran verrouillé, « Se fier » non accepté, logiciel Apple manquant, câble ou port défectueux.
2. **Inventorie** les fichiers visibles par dossier, par type (PNG, JPG, HEIC, MP4, MOV…) et par année, sans rien copier. Sur Android, il signale le dossier `.thumbnails`.
3. **Scanne le PC** : sauvegardes de téléphone (iTunes, Appareils Apple), iCloud Photos, OneDrive, Google Drive, Téléchargements, corbeille Windows, taille du cache de miniatures.
4. **Liste les endroits à vérifier à la main** : « Supprimés récemment » (iPhone), corbeille Google Photos, icloud.com, corbeilles en ligne.
5. **Optionnel, avec accord explicite** : extrait les aperçus JPEG/PNG du cache de miniatures Windows dans un dossier local, sans doublons.
6. **Rédige un rapport chiffré** et propose le ménage (corbeille, Nettoyage de disque), sans jamais supprimer lui-même de façon définitive.

## Exemples de demandes

- « Fais le test des photos supprimées sur mon iPhone. »
- « Mon téléphone Android est branché : qu'est-ce que le PC peut voir ? »
- « Est-ce que mon ordinateur garde des copies de mes photos effacées ? »

## Fichiers

| Fichier | Rôle |
| --- | --- |
| `SKILL.md` | La méthode suivie par Claude, étape par étape, et les règles de sécurité |
| `scripts/windows/1-detecter-telephone.ps1` | Détection USB et diagnostic de l'accès au stockage |
| `scripts/windows/2-inventaire-telephone.ps1` | Comptage par dossier, type et année |
| `scripts/windows/3-scanner-pc.ps1` | Recherche des copies et traces sur le PC |
| `scripts/windows/5-extraire-miniatures.ps1` | Extraction optionnelle du cache de miniatures (paramètre `-Sortie`) |
| `reference/mac.md` | Les mêmes vérifications sur Mac, en commandes Terminal |

Les scripts marchent aussi sans Claude :

```powershell
powershell -ExecutionPolicy Bypass -File scripts\windows\1-detecter-telephone.ps1
```

## Garde-fous

- Lecture seule, sauf l'extraction optionnelle des miniatures.
- Aucune image, miniature ou liste de fichiers n'est envoyée en ligne ; le rapport ne contient que des chiffres.
- Aucune suppression définitive : corbeille, ou outil Windows lancé par la personne elle-même.
- Claude n'ouvre pas les images extraites sans demande : elles peuvent contenir des documents sensibles.

## Prérequis

- Windows 10 ou 11 avec PowerShell 5.1 (inclus), ou un Mac (voir `reference/mac.md`).
- Un câble USB d'origine ou certifié, branché sans hub.
- iPhone sur Windows : l'application gratuite **Appareils Apple** si le stockage reste vide.

## Limites

- Sur iPhone, Windows ne voit que la pellicule actuelle : les photos supprimées n'y apparaissent jamais.
- Une miniature est un aperçu en basse résolution ; on ne peut pas savoir de quel fichier elle vient.
- La partie Mac n'a pas encore été testée sur une vraie machine.
- Ce skill sert à vérifier **vos propres** appareils.
