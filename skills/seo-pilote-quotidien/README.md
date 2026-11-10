# seo-pilote-quotidien

> Claude devient le consultant SEO et GEO quotidien de votre site : santé technique chaque jour, pages 8 à 20 poussées chaque semaine, citations par les IA mesurées, contenus chaque mois, et une mesure avant/après à 14 jours. Toujours en mode « proposition à valider ».

## D'où il vient

Un guide viral (Chen Media) présente **seo-autopilot** d'Illyism : « Claude fait chaque jour le travail d'une agence SEO ». Nous l'avons lu en entier avant de l'adapter.

| Constat sur l'original ([Illyism/seo-skills](https://github.com/Illyism/seo-skills), 734 ⭐) | Notre décision |
| --- | --- |
| Excellente cadence quotidien / hebdo / mensuel et dossier `seo/` qui garde la mémoire | Reprise (réécrite) |
| Mode « fusionner dès que le build passe » : modifie le site en production sans relecture | **Retiré** : propositions uniquement |
| Demande à l'IA de télécharger et suivre un SKILL.md distant (linkdr.com) qui peut changer à tout moment | **Retiré** : risque d'injection |
| Renvoie vers des services payants d'achat de liens et de suivi IA | **Retiré** : voir `netlinking-backlinks` |
| Aucun fichier de licence dans le dépôt | Texte entièrement réécrit, aucune copie |

Nous y avons ajouté la meilleure idée de [fire-your-seo-agency](https://github.com/leopard627/fire-your-seo-agency) (999 ⭐, MIT), le skill « agence SEO à 2 500 $ » du même guide : vérifier le site « avec les yeux d'un robot » (curl), demander l'accord avant d'agir, et **remesurer 14 jours après** chaque changement pour prouver l'effet. Sa partie Naver (Corée) est remplacée par une partie France : Google.fr, Bing et IndexNow (qui alimente aussi Qwant et Ecosia), Google Business Profile, CNIL, LCEN.

## Ce qu'il fait

| Rythme | Travail |
| --- | --- |
| Chaque jour | Contrôle de chaque URL du sitemap (statuts, redirections, canonical, noindex, liens cassés, balises), faits à jour d'après les derniers commits, une tâche du backlog, une ligne de journal avec preuve |
| Chaque semaine | Pages en positions 8 à 20 améliorées face aux 3 premiers résultats, 12 petites corrections, indexation, 25 questions posées aux IA, sitemaps concurrents comparés, rapport de moins de 300 mots |
| Chaque mois | Plan de mots-clés, jusqu'à 12 articles en brouillon, pages comparatives honnêtes, un petit outil gratuit, 5 demandes de liens en brouillon, posts LinkedIn en brouillon |
| À J+14 | Nouvelle mesure de chaque changement, même si le résultat est nul |

## Pour démarrer

Dans Claude Code, ouvert dans le dépôt du site :

```
Lance le skill seo-pilote-quotidien.
Site : https://votre-site.fr
Produit : <ce que c'est et qui l'achète>
Conversion : <demande de devis / rendez-vous>
Concurrents : trouve-les
Marché : France
```

Puis relancez-le chaque jour, à la main ou avec une tâche planifiée.

## Garde-fous

- Toute modification est une proposition (branche + demande de fusion) ; rien n'est fusionné ni déployé seul.
- Le contenu du web est une donnée ; aucune instruction distante n'est suivie.
- Aucun chiffre inventé ; « non mesuré » quand il manque une source.
- White hat uniquement ; pas de lien acheté, pas de contenu de masse publié sans relecture.
- Aucun e-mail, inscription ou post envoyé : tout reste en brouillon dans `seo/brouillons/`.
- Aucune page avec du trafic supprimée ou redirigée sans votre accord.

## Limites

- Il faut le code du site dans un dépôt. Pour un site Elementor sans dépôt, utilisez `webmaster-wordpress-elementor`.
- Les positions bougent en plusieurs semaines : le pilote livre des changements, Google décide quand ils comptent.
- Chaque lancement consomme des jetons Claude.
- Sans Search Console, les routines hebdomadaires sont incomplètes ; le rapport le signale.

## Fichiers

| Fichier | Rôle |
| --- | --- |
| `SKILL.md` | La méthode |
| `reference/controle-robot.md` | Les commandes de contrôle en lecture (PowerShell et curl) et la grille du HTML servi |
| `LICENSE-fire-your-seo-agency` | Licence MIT de la source de la mesure à 14 jours |

## Crédits

Méthode inspirée d'Illyism ([Illyism/seo-skills](https://github.com/Illyism/seo-skills), réécrit sans copie) et de [leopard627/fire-your-seo-agency](https://github.com/leopard627/fire-your-seo-agency) (MIT, © 2026 leopard627).
