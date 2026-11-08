# publier-skills-github

> Transformer vos skills personnels en un dépôt GitHub propre, documenté et installable par tous : en une commande dans Claude Code, ou par import d'un ZIP dans l'application Claude.

## Pourquoi ce skill

C'est la méthode qui a servi à construire ce dépôt-ci. Un skill qui reste dans votre application ne sert qu'à vous ; publié proprement, il devient une vitrine de votre expertise et un outil que d'autres installent en une minute.

## Comment il travaille

| Étape | Ce que fait Claude |
| --- | --- |
| 1. Inventaire | Liste vos skills (application et Claude Code), lit chacun en entier, repère l'origine, la licence d'origine et toute donnée sensible |
| 2. Structure | Organise le dépôt : `skills/<nom>/`, `.claude-plugin/marketplace.json`, `dist/`, `LICENSE`, `README.md` |
| 3. Documentation | Écrit un README détaillé par skill à partir du modèle |
| 4. Catalogue | Écrit le README principal (logo, badges, tableau, installation, crédits) et la licence choisie |
| 5. Contrôle | Lance `construire-depot.ps1` et le scanner de sécurité, corrige les erreurs |
| 6. Publication | Par git, GitHub CLI, ou le navigateur si git n'est pas installé |
| 7. Vérification | Ouvre le dépôt publié et vous donne le lien, la commande d'installation et les ZIP |

## Le script de contrôle

```powershell
powershell -ExecutionPolicy Bypass -File scripts\construire-depot.ps1 -Depot C:\chemin\du\depot
```

Pour chaque skill, il vérifie :

- le frontmatter en tête de `SKILL.md` ;
- un `name` identique au nom du dossier, en minuscules avec tirets, de 64 caractères au plus ;
- une `description` de 60 à 1 024 caractères ;
- la présence d'un `README.md` ;
- l'existence des fichiers cités (`scripts/…`, `reference/…`, `templates/…`) ;
- l'absence de tirets cadratins (règle de style Pionarius, simple avertissement).

Puis il met à jour la liste des skills dans `marketplace.json` et fabrique `dist/<skill>.zip` pour l'application Claude. Code de sortie 1 s'il reste une erreur.

## Ce que vous recevez

- Un dépôt public ou privé, au nom de votre choix.
- L'installation en une commande : `/plugin marketplace add <compte>/<depot>`.
- Un ZIP par skill à importer dans l'application Claude.
- Un README par skill et un catalogue complet.
- Les crédits et licences d'origine conservés.

## Exemples de demandes

- « Mets tous mes skills sur GitHub, bien documentés. »
- « Ajoute ce nouveau skill à mon dépôt et mets à jour le catalogue. »
- « Crée un dépôt privé pour les skills de mon équipe. »

## Garde-fous

- Chaque fichier est lu en entier avant publication ; les données sensibles sont retirées.
- Claude ne saisit jamais votre mot de passe GitHub : vous vous connectez vous-même.
- Créer un dépôt public, changer la photo ou la bio du compte : seulement avec votre accord.
- Pas de `push --force`, pas de suppression sur le dépôt.

## Fichiers

| Fichier | Rôle |
| --- | --- |
| `SKILL.md` | La méthode en 7 étapes |
| `scripts/construire-depot.ps1` | Contrôle, mise à jour de `marketplace.json`, fabrication des ZIP |
| `templates/README-skill.md` | Modèle de README pour un skill |
| `templates/marketplace.json` | Modèle de fichier d'installation pour Claude Code |

## Limites

- Le script est pour Windows (PowerShell 5.1+). Sur Mac, les contrôles se font à la main en suivant la liste ci-dessus.
- La publication par le navigateur crée un commit par dossier ; c'est plus lent que git, mais ne demande rien à installer.
