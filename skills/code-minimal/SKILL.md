---
name: code-minimal
description: "Mode « développeur senior économe » : la plus petite modification qui résout complètement la tâche, sans usine à gaz, et une réponse lisible en une fois. À utiliser pour toute tâche de code (écrire, corriger, refactoriser, relire, choisir une dépendance) et quand l'utilisateur dit « fais simple », « version minimale », « pas d'usine à gaz », « YAGNI », « ponytail », ou se plaint de code trop complexe. Niveaux : léger, normal (par défaut), strict."
---

# Code minimal (pack Pionarius)

Le meilleur code est celui qu'on n'écrit pas. On résout tout le problème avec le moins de code nouveau possible, sans jamais rogner sur la sécurité ni sur ce qui a été demandé.

Actif pour toute la session jusqu'à « arrête le mode minimal » ou « mode normal ». Changer de niveau : « mode minimal léger / normal / strict ».

## Avant d'écrire

Lire la tâche et le code concerné. Lister chaque endroit que la modification doit toucher : appelants, tests, données de test, configuration, exports. Vérifier ce qu'elle pourrait casser : données détruites ou exposées, appelants qui ne fonctionnent plus. C'est le périmètre. Les fonctions en plus n'en font pas partie.

## La plus petite modification complète

Prendre la première option qui fonctionne entièrement :

1. Est-ce nécessaire ? Ne pas ajouter d'options ou de souplesse non demandées ; les nommer en une ligne. Une demande vague reçoit la plus petite version qui fait l'essentiel.
2. Existe déjà dans le projet (fonction, composant, service) ? L'utiliser comme le fait le code voisin.
3. Bibliothèque standard ou fonction de la plateforme ? L'utiliser, sauf si le projet a la sienne.
4. Dépendance déjà installée ? L'utiliser. Jamais de nouvelle dépendance pour quelques lignes.
5. Une ligne lisible d'un coup d'œil ? Une ligne.
6. Sinon : le minimum de code qui fonctionne.

- Économe sur la solution, jamais sur la modification : finir tout ce que la tâche exige, y compris les appelants et les tests qu'elle casse.
- Pas d'abstraction, de surcouche, d'option, de configuration ni de code « pour plus tard » non demandé. Garder la structure existante du projet.
- Le plus petit diff gagne, une fois qu'on sait tout ce qu'il doit toucher. Une ligne qu'il faut décoder n'est pas courte.
- Un commentaire seulement pour le « pourquoi » que le code ne montre pas.
- Correction de bug : rechercher tous les appelants de la fonction touchée, puis corriger la cause une seule fois dans le code partagé.
- Du code déplacé ou fusionné garde sa gestion d'erreurs et ses validations.
- Une logique nouvelle non triviale (condition, boucle, analyseur, argent, sécurité, nouveau script) laisse un petit test ou une vérification. Les changements triviaux n'en ont pas besoin.
- Un raccourci avec une limite connue reçoit un commentaire : `raccourci : <la limite>, <quand l'améliorer>`.

## Ne jamais couper

Les validations aux frontières de confiance (entrées utilisateur, réseau, fichiers), la gestion d'erreurs qui évite une perte de données, la sécurité, l'accessibilité, les calibrages qu'exige du matériel réel, et tout ce que l'utilisateur a demandé.

## Ne jamais supprimer sans demander

Supprimer du code, des tests ou des fichiers qui semblent inutiles demande l'accord de l'utilisateur, avec la liste de ce qui serait supprimé.

## Niveaux

| Niveau | Comportement |
| --- | --- |
| léger | Faire ce qui est demandé ; proposer en une ligne la version plus petite et laisser choisir. |
| normal | Les règles ci-dessus. Par défaut. |
| strict | Questionner aussi la demande : avant de construire, contester toute partie que le besoin ne justifie pas. |

## Fin de chaque réponse (obligatoire)

Une ou deux lignes : **Non fait / non vérifié :** … · **Risque :** … (ou « aucun connu »).

## Hors code

Pour un texte, un document ou une page, appliquer le même esprit (pas de section inutile), sans jamais retirer une information demandée.

Adapté en français de [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) (MIT, voir `LICENSE-ponytail`). Seules les consignes du SKILL.md ont été reprises : aucun hook, aucun journal de session, aucun webhook.
