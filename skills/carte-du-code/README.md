# carte-du-code

> Comprendre n'importe quel projet sans rien installer : Claude dresse la carte des modules, des points d'entrée, des dépendances et des zones à risque, l'enregistre dans un fichier Markdown, puis s'en sert pour répondre vite à vos questions.

## D'où il vient

[graphify](https://github.com/Graphify-Labs/graphify) (environ 145 000 étoiles, Apache-2.0) transforme un projet en graphe de connaissances. L'idée est excellente ; l'outil, lourd et exposé :

| graphify | carte-du-code |
| --- | --- |
| Paquet Python à installer (`graphifyy`, avec deux y, piège à typosquattage) + prérequis `curl \| sh` | Rien à installer |
| Hooks qui interceptent Read, Grep et Bash | Aucun hook |
| SKILL.md de 50 Ko qui exécute du `python -c` en continu | SKILL.md de 4 Ko, lecture seule |
| Injection de commandes possible via des libellés tirés du contenu (issue #4309, ouverte) | Jamais de texte du projet dans une commande |
| Lecture de fichiers hors projet via `#include` (alerte GHSA-pcc4-rvhr-2pr8, corrigée en 0.9.70) | Lecture limitée au dossier demandé |
| Documents envoyés à Gemini automatiquement si une clé Google est présente, sans masquage des secrets (issue #2781) | Rien ne quitte la session ; secrets cités par nom seulement |
| Graphe JSON + visualisation HTML | Carte Markdown lisible et versionnable |

Ce que l'on perd : la visualisation interactive et le gain de jetons sur des projets géants. Ce que l'on gagne : zéro installation, zéro risque d'exécution, une carte que vous pouvez lire vous-même.

## Ce que contient la carte

Résumé du projet, schéma des modules, points d'entrée, tableau des modules (rôle, fichiers clés, dépend de, utilisé par), données et services externes, zones à risque (fichiers énormes, code sans test, secrets possibles en clair, TODO), et une section « Où trouver… ». Chaque affirmation renvoie à `fichier:ligne`.

## Exemples de demandes

- « Explique-moi comment est organisé ce thème WordPress. »
- « Fais la carte de ce projet avant qu'on le modifie. »
- « Où est géré l'envoi des e-mails dans ce code ? »

## Crédits

Idée inspirée de [Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify) (Apache-2.0). Aucun code ni texte repris.
