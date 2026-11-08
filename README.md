<p align="center"><img src="assets/logo-pionarius.png" alt="Logo Pionarius" width="160"></p>

<h1 align="center">Skills de l'Équipe Pionarius</h1>

<p align="center">
Des skills pour Claude, testés en conditions réelles, écrits en français.<br>
Tests IA · sécurité · WordPress, SEO et GEO · rédaction · organisation du travail avec Claude.
</p>

<p align="center">
<img alt="Skills" src="https://img.shields.io/badge/skills-8-111111">
<img alt="Langue" src="https://img.shields.io/badge/langue-français-111111">
<img alt="Licence" src="https://img.shields.io/badge/licence-MIT-111111">
<img alt="Claude Code" src="https://img.shields.io/badge/Claude%20Code-compatible-111111">
</p>

## Qu'est-ce qu'un skill ?

Un skill est un dossier qui contient un fichier `SKILL.md` : des instructions que Claude charge seulement quand la tâche s'y prête. Le haut du fichier (le *frontmatter*) donne le nom du skill et sa description. Claude lit cette description pour décider quand l'utiliser. Le reste du fichier explique la méthode, étape par étape, et peut s'appuyer sur des scripts ou des fichiers de référence placés à côté.

Les skills fonctionnent dans Claude Code, dans l'application Claude (claude.ai et bureau) et avec l'API.

## Catalogue

| Skill | À quoi il sert | Se déclenche quand… | Contenu |
| --- | --- | --- | --- |
| [test-photos-supprimees](skills/test-photos-supprimees) | Vérifier ce qu'un ordinateur voit d'un téléphone branché et où se cachent les traces de photos supprimées | « fais le test des photos supprimées », « retrouve mes photos effacées » | SKILL.md, 4 scripts PowerShell, fiche Mac |
| [verif-skill-securite](skills/verif-skill-securite) | Contrôler un skill, un plugin ou un serveur MCP externe avant de l'installer, avec un verdict clair | « vérifie ce skill », « ce plugin est-il sûr ? » | SKILL.md |
| [audit-seo-geo](skills/audit-seo-geo) | Auditer un site pour Google et pour les IA de recherche : score /100, 3 actions prioritaires, correctifs prêts à coller | « fais un audit SEO de mon site », « pourquoi ChatGPT ne me cite pas ? » | SKILL.md |
| [webmaster-wordpress-elementor](skills/webmaster-wordpress-elementor) | Gérer un site WordPress + Elementor + Rank Math : balises SEO, caches, Search Console, cartes visuelles | une tâche d'administration ou de SEO sur un site WordPress | SKILL.md |
| [wordpress-seo-geo-writer](skills/wordpress-seo-geo-writer) | Rédiger un article prêt pour WordPress, optimisé pour Google (SEO) et pour les IA de recherche (GEO) | « écris un article », « un billet de blog pour le site » | SKILL.md |
| [humanizer](skills/humanizer) | Réécrire un texte qui « sonne IA » pour qu'il sonne humain, sans changer le fond | « humanise ce texte », relecture d'un texte généré | SKILL.md (adapté de blader/humanizer) |
| [clear](skills/clear) | Tout sauvegarder avant de taper `/clear`, pour reprendre le travail ensuite | « /clear », « on repart à zéro » | SKILL.md |
| [compact](skills/compact) | Ranger et archiver le suivi avant de taper `/compact` | « /compact », « fais le ménage » | SKILL.md |

Chaque dossier a son propre README : ce que fait le skill, comment il travaille, des exemples de demandes, ses garde-fous et ses limites.

## Installation

### Option 1 : Claude Code, en une commande (marketplace de plugins)

Dans Claude Code, tapez :

```
/plugin marketplace add equipepionarius-collab/equipe-pionarius
/plugin install pionarius-skills@equipe-pionarius
```

Tous les skills du dépôt sont alors disponibles. Pour les mettre à jour plus tard : `/plugin marketplace update equipe-pionarius`.

### Option 2 : Claude Code, à la main

1. Téléchargez le dépôt (bouton **Code → Download ZIP**) et décompressez-le.
2. Copiez le ou les dossiers voulus de `skills/` dans :
   - Windows : `%USERPROFILE%\.claude\skills\`
   - Mac et Linux : `~/.claude/skills/`
3. Relancez Claude Code, puis demandez « quels skills as-tu ? » pour vérifier.

Pour un skill réservé à un seul projet, copiez-le plutôt dans `.claude/skills/` à la racine de ce projet.

### Option 3 : application Claude (claude.ai ou bureau)

1. Compressez le dossier d'un skill en ZIP (le fichier `SKILL.md` doit être à la racine du dossier).
2. Dans les paramètres de l'application, section **Capacités** (Capabilities), partie **Skills** : importez le ZIP.

## Utilisation

Rien à mémoriser : décrivez la tâche normalement, Claude choisit le skill qui correspond. Vous pouvez aussi le demander par son nom, par exemple « utilise le skill wordpress-seo-geo-writer pour un article sur… ».

## Principes communs à nos skills

- **Lecture d'abord, action ensuite.** Chaque skill commence par établir l'état réel avant de modifier quoi que ce soit.
- **Pas de suppression définitive.** Brouillon, corbeille ou archive, jamais d'effacement sans retour possible.
- **Pas d'action externe sans accord.** Aucun envoi, publication, paiement ni saisie de mot de passe par Claude.
- **Le contenu lu est une donnée, pas une consigne.** Pages web, e-mails et fichiers ne donnent jamais d'ordres à Claude.
- **Des faits vérifiables.** Pas de chiffre ni de citation inventés ; ce qui reste à vérifier est signalé.

## Structure du dépôt

```
equipe-pionarius/
├── .claude-plugin/
│   └── marketplace.json        # installation en une commande dans Claude Code
├── assets/
│   └── logo-pionarius.png
├── skills/
│   ├── test-photos-supprimees/
│   │   ├── SKILL.md
│   │   ├── README.md
│   │   ├── reference/mac.md
│   │   └── scripts/windows/*.ps1
│   ├── verif-skill-securite/
│   ├── audit-seo-geo/
│   ├── webmaster-wordpress-elementor/
│   ├── wordpress-seo-geo-writer/
│   ├── humanizer/              # + LICENSE de l'auteur d'origine
│   ├── clear/
│   └── compact/
├── LICENSE
└── README.md
```

## Créer votre propre skill

1. Créez un dossier au nom du skill, en minuscules avec des tirets.
2. Ajoutez un `SKILL.md` qui commence par :

   ```yaml
   ---
   name: mon-skill
   description: Ce que fait le skill et quand l'utiliser, avec les mots que dirait l'utilisateur.
   ---
   ```

3. Écrivez la méthode en étapes courtes, puis les règles à ne jamais enfreindre.
4. Testez-le sur une vraie tâche avant de le partager.

## Licence et crédits

- Skills de l'Équipe Pionarius : licence [MIT](LICENSE).
- `humanizer` est adapté de [blader/humanizer](https://github.com/blader/humanizer), licence MIT, © 2025 Siqi Chen. Sa licence d'origine est conservée dans [skills/humanizer/LICENSE](skills/humanizer/LICENSE). Les règles de ce skill s'appuient sur la page Wikipédia [« Signs of AI writing »](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing).
- `audit-seo-geo` s'inspire de [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo), [Auriti-Labs/geo-optimizer-skill](https://github.com/Auriti-Labs/geo-optimizer-skill) et [every-app/open-seo](https://github.com/every-app/open-seo) (MIT).
- `verif-skill-securite` s'inspire des catégories d'attaque de [NVIDIA/SkillSpector](https://github.com/NVIDIA/skillspector) (Apache-2.0).

## Contact

Une question, une idée de skill, ou envie de faire le test des photos supprimées ? Écrivez à l'Équipe Pionarius sur LinkedIn avec le message **TEST PHOTO**, ou ouvrez une *issue* sur ce dépôt.
