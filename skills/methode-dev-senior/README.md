# methode-dev-senior

> La méthode de travail d'un développeur senior, en un seul skill français : cadrer, spécifier, découper, construire par tranches, déboguer, relire, livrer avec une vraie définition du « terminé ».

## D'où il vient

[addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) (environ 115 000 étoiles, licence MIT) est la collection d'Addy Osmani, qui a passé plus de 14 ans chez Google (dernièrement directeur chez Google Cloud AI) avant de rejoindre Anthropic. La presse l'appelle souvent « les agent skills de Google », mais c'est un dépôt personnel.

La collection compte 25 skills de 9 à 22 Ko chacun, soit environ 300 Ko d'instructions. Nous en avons tiré l'essentiel dans un seul skill de 5 Ko.

| Élément d'origine | Dans notre version |
| --- | --- |
| Les 6 comportements non négociables (`using-agent-skills`) | Repris et traduits |
| Arbre de décision vers 25 skills | Réduit à 7 phases |
| interview-me, spec-driven, planning, incremental, debugging, code-review, définition du « terminé » | Condensés en 7 sections |
| Hooks optionnels avec appels réseau (issues #106 et #295 : SSRF, empoisonnement de cache) | Non repris |
| Pas de règle explicite sur les actions dangereuses | Ajoutée : supprimer, écraser, `--force`, migrer, déployer, envoyer, payer demandent un accord |

## Les six comportements

1. Annoncer ses hypothèses.
2. S'arrêter en cas de doute et poser la question.
3. Contredire quand c'est justifié, sans flatterie.
4. Rester simple.
5. Rester dans le périmètre, ne rien supprimer sans accord.
6. Prouver, ne pas supposer.

## Exemples de demandes

- « Je veux une automatisation qui relance mes devis non signés : par où commencer ? »
- « Mon formulaire WordPress n'envoie plus les e-mails. »
- « Relis ce script avant que je le mette en production. »

## Crédits

Adapté de [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills), © 2025 Addy Osmani, licence MIT (`LICENSE-agent-skills`). À combiner avec [code-minimal](../code-minimal).
