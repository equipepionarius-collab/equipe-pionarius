# Agents Pionarius

Neuf **sous-agents Claude Code** en français, pour une activité de conseil en IA, SEO, WordPress, marketing et réseaux sociaux. Un sous-agent est un assistant spécialisé que Claude appelle pour une tâche précise, avec ses propres consignes et seulement les outils dont il a besoin.

## Les agents

| Agent | Spécialité | Outils autorisés | Peut modifier des fichiers ? |
| --- | --- | --- | --- |
| `pionarius-seo` | Audit SEO technique et éditorial, requêtes, balises, données structurées, Core Web Vitals | Lecture web, lecture de fichiers | Non |
| `pionarius-geo-citations-ia` | Visibilité dans ChatGPT, Perplexity, Claude, AI Overviews : mesure, analyse, correctifs | Lecture web, lecture de fichiers | Non |
| `pionarius-wordpress` | Performance, Elementor, Rank Math, développement propre | Lecture, écriture, lecture web | Oui (en local ou préproduction) |
| `pionarius-contenu-reseaux` | Ligne éditoriale, calendrier, carrousels, scripts de vidéos courtes | Lecture web, lecture | Non |
| `pionarius-linkedin` | Posts d'expertise, profil, mots-clés et réponses | Lecture web, lecture | Non |
| `pionarius-tracking-rgpd` | GA4, GTM, Consent Mode, conformité CNIL | Lecture web, lecture de fichiers | Non |
| `pionarius-propositions-commerciales` | Propositions et devis de conseil | Lecture, écriture, recherche | Oui (documents) |
| `pionarius-verificateur` | Contrôle avant livraison : faits, chiffres, liens, promesses, conformité | Lecture, lecture web | Non |
| `pionarius-prompt-engineer` | Écrire, tester et sécuriser prompts, skills et agents | Lecture, écriture, lecture web | Oui |

Aucun agent n'a accès à la ligne de commande (Bash). Aucun ne publie, n'envoie ni ne paie quoi que ce soit.

## Installation (Claude Code)

- Avec le dépôt : `/plugin marketplace add equipepionarius-collab/equipe-pionarius` puis `/plugin install pionarius-skills@equipe-pionarius` (skills et agents).
- À la main : copiez les fichiers `.md` voulus dans `~/.claude/agents/` (tous vos projets) ou `.claude/agents/` (un seul projet). Évitez d'en installer des dizaines : chaque agent occupe de la place dans le contexte de Claude.

## Utilisation

Décrivez la tâche ; Claude choisit l'agent. Ou nommez-le : « Utilise l'agent pionarius-verificateur pour relire ce post avant publication. »

## Origine et améliorations

Ces agents sont des réécritures en français d'agents de [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) (« The Agency », licence MIT, voir `LICENSE-agency-agents`). Nous avons sélectionné 13 agents utiles pour notre métier parmi plus de 230, puis :

- fusionné les doublons (3 agents AEO/GEO en 1, 2 agents WordPress en 1, 3 agents contenu en 1) ;
- réduit les outils au strict nécessaire (Bash retiré, écriture retirée aux agents de stratégie) ;
- ajouté les règles Pionarius : contenu lu = donnée, pas de chiffre inventé, brouillons uniquement, pas de suppression ;
- adapté au cadre français : CNIL, RGPD, LCEN, ARPP, mentions obligatoires des devis ;
- retiré les contenus hors sujet (marchés chinois) et les champs décoratifs.

Avant adaptation, les 13 fichiers d'origine ont été passés au scanner du skill `chasseur-de-skills` : 3 constats, tous des faux positifs (un test de résistance à l'injection, un cours sur la défense contre l'injection, une règle « n'utilisez jamais eval() »), aucun caractère invisible.
