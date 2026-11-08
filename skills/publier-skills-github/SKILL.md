---
name: publier-skills-github
description: "Publie un ou plusieurs skills Claude sur GitHub dans un dépôt propre et installable par tous, avec un dossier par skill, un README détaillé, un catalogue, la licence et les crédits, un marketplace.json pour Claude Code et des ZIP prêts à importer dans l'application Claude. À utiliser quand on demande « mets mes skills sur GitHub », « publie ce skill », « crée un dépôt pour mes skills »."
---

# Publier des skills sur GitHub (pack Pionarius)

Transforme des skills personnels en un dépôt GitHub que n'importe qui peut installer : en une commande dans Claude Code, ou par import d'un ZIP dans l'application Claude.

## Règles non négociables

1. **Lire chaque fichier avant de le publier.** Publier, c'est diffuser : rien ne part sans avoir été lu en entier.
2. **Aucune donnée sensible** : mot de passe, clé d'API, jeton, adresse e-mail personnelle, nom de client non autorisé, chemin contenant un nom de personne. Les signaler et les retirer avant publication.
3. **Licences et crédits** : un skill repris ou adapté garde la mention de son auteur et sa licence d'origine dans son dossier.
4. **Jamais de mot de passe saisi par Claude** : la connexion à GitHub est faite par l'utilisateur.
5. **Accord explicite** avant de créer un dépôt public, de changer la photo ou la bio du compte.
6. **Pas de suppression définitive** sur le dépôt ; une erreur se corrige par un nouveau commit.

## Étape 1 : Inventaire

1. Lister les skills de l'utilisateur :
   - application Claude : le manifeste du plugin de skills (`creatorType: "user"` = créés par l'utilisateur) ;
   - Claude Code : `~/.claude/skills/` et `.claude/skills/` du projet.
2. Lire chaque `SKILL.md` et ses fichiers en entier.
3. Pour chacun : origine (création ou adaptation), licence d'origine, données sensibles. Présenter ce bilan et faire valider la liste.

## Étape 2 : Structure du dépôt

```
<depot>/
├── .claude-plugin/marketplace.json   # installation en une commande dans Claude Code
├── assets/logo.png                   # facultatif
├── dist/<skill>.zip                  # ZIP à importer dans l'application Claude
├── skills/<skill>/
│   ├── SKILL.md                      # frontmatter name + description
│   ├── README.md                     # documentation détaillée
│   ├── LICENSE                       # seulement si licence d'origine différente
│   ├── scripts/                      # facultatif
│   └── reference/                    # facultatif
├── LICENSE
└── README.md                         # catalogue
```

Modèles prêts : `templates/README-skill.md`, `templates/marketplace.json`.

## Étape 3 : Documenter chaque skill

Le `README.md` de chaque skill suit le modèle et contient : une phrase de résumé ; pourquoi ce skill ; comment il travaille (tableau d'étapes) ; ce que l'utilisateur reçoit ; 3 exemples de demandes ; garde-fous ; prérequis ; fichiers ; limites ; crédits. Il décrit ce que fait réellement le SKILL.md, sans promesse en plus.

## Étape 4 : Catalogue et licence

- `README.md` racine : logo, badges, tableau catalogue (skill, à quoi il sert, quand il se déclenche, contenu), 3 modes d'installation, principes communs, structure, crédits.
- `LICENSE` : demander la licence voulue. Par défaut MIT, qui autorise la réutilisation. Sans licence, personne ne peut légalement réutiliser.

## Étape 5 : Contrôle automatique

```powershell
powershell -ExecutionPolicy Bypass -File scripts/construire-depot.ps1 -Depot <racine-du-depot>
```

Le script vérifie chaque skill (frontmatter, nom identique au dossier, nom en minuscules avec tirets, description de 60 à 1024 caractères, README présent, fichiers cités existants), met à jour la liste des skills dans `marketplace.json` et fabrique `dist/<skill>.zip`. Corriger toute ERREUR avant de publier. Passer aussi chaque skill au scanner de `chasseur-de-skills`.

## Étape 6 : Publier

Par ordre de préférence :

1. **git** (si installé) : `git init`, commit, `git remote add origin`, `git push`. Ne jamais forcer un push (`--force`) sans accord.
2. **GitHub CLI** (`gh`) : `gh repo create <compte>/<depot> --public --source . --push`.
3. **Navigateur** (sans git) : créer le dépôt sur github.com/new, puis pour chaque dossier ouvrir `https://github.com/<compte>/<depot>/upload/main/<chemin>`, y déposer les fichiers de ce dossier, valider (« Commit changes »). Un dossier qui commence par un point (`.claude-plugin`) se crée de la même façon.

Ensuite : description et thèmes du dépôt (« About »), et, si l'utilisateur le demande, logo et bio du compte.

## Étape 7 : Vérifier

Ouvrir le dépôt publié : chaque dossier de `skills/` contient bien ses fichiers, le README s'affiche avec le logo, `marketplace.json` est à jour. Donner à l'utilisateur :

- le lien du dépôt ;
- la commande d'installation : `/plugin marketplace add <compte>/<depot>` puis `/plugin install <plugin>@<marketplace>` ;
- le lien des ZIP (`dist/`) pour l'application Claude ;
- ce qui n'a pas été testé.

## Mise à jour d'un dépôt existant

Ajouter le dossier du nouveau skill, son README, puis relancer le script de contrôle (il met à jour `marketplace.json` et les ZIP), mettre à jour le catalogue et le badge du nombre de skills, augmenter `metadata.version` dans `marketplace.json`, publier les fichiers modifiés seulement.
