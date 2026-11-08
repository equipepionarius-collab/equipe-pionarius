<p align="center"><img src="assets/logo-pionarius.png" alt="Logo Pionarius" width="160"></p>

# Équipe Pionarius

Des outils simples pour tester, en conditions réelles, ce que l'IA sait vraiment faire avec nos données.

## Skill : test des photos supprimées

Un témoignage viral affirme qu'un utilisateur a retrouvé 214 856 photos « supprimées » grâce à Claude Code. Ce skill permet de refaire le test soi-même, honnêtement : il montre ce que l'ordinateur voit d'un téléphone branché, et où se cachent vraiment les traces de photos effacées.

**Ce qu'il fait**

1. Détecte le téléphone (iPhone ou Android) et explique pourquoi l'accès est bloqué : écran verrouillé, « Se fier », logiciel Apple manquant, câble défectueux.
2. Compte les fichiers visibles par type et par année, sans rien copier.
3. Cherche les copies sur le PC : sauvegardes, iCloud, OneDrive, Google Drive, corbeille, cache de miniatures.
4. Indique les endroits à vérifier à la main (« Supprimés récemment », corbeilles en ligne).
5. Optionnel, avec votre accord : extrait les aperçus du cache de miniatures Windows.
6. Fait un rapport chiffré et propose le ménage.

**Ses garanties**

- Lecture seule, sauf l'extraction optionnelle.
- Aucune image ne quitte l'ordinateur.
- Aucune suppression définitive.

### Notre résultat

| | Témoignage viral | Notre test |
| --- | --- | --- |
| Téléphone | Google Pixel (Android) | iPhone |
| Ordinateur | MacBook | PC Windows 11 |
| Fichiers « cachés » sur le téléphone | Plus de 214 000 miniatures | Aucun : 862 fichiers de la pellicule |
| Images effacées retrouvées | Sur le téléphone | Sur le PC : 1 230 miniatures |

## Installation

1. Téléchargez ce dépôt (bouton **Code → Download ZIP**) et décompressez-le.
2. Copiez le dossier `skills/test-photos-supprimees` dans :
   - Windows : `%USERPROFILE%\.claude\skills\`
   - Mac : `~/.claude/skills/`
3. Ouvrez Claude Code et écrivez : « Fais le test des photos supprimées sur mon téléphone ».

Les scripts Windows fonctionnent aussi seuls :

```powershell
powershell -ExecutionPolicy Bypass -File skills\test-photos-supprimees\scripts\windows\1-detecter-telephone.ps1
```

## Prérequis

- iPhone sur Windows : application **Appareils Apple** (Microsoft Store).
- Un câble USB d'origine ou certifié, branché directement sur l'ordinateur.
- Le téléphone déverrouillé, accès autorisé (« Se fier » ou « Transfert de fichiers »).

## Avertissement

Ces outils servent à vérifier **vos propres** appareils. Les aperçus extraits peuvent contenir des documents sensibles : gardez-les en local et supprimez-les après usage.
