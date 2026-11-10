# code-minimal

> Le mode « développeur senior économe » : la plus petite modification qui résout entièrement la tâche, sans usine à gaz, et une réponse qui se lit d'une traite. Version française et sécurisée de **ponytail**.

## D'où il vient

[ponytail](https://github.com/DietrichGebert/ponytail) (environ 188 000 étoiles, licence MIT) est l'un des skills les plus partagés de 2026. Le texte du skill est excellent. Le plugin complet, lui, en fait beaucoup plus :

| Élément de ponytail | Repris ? | Pourquoi |
| --- | --- | --- |
| Les consignes du SKILL.md | Oui, traduites et adaptées | Solides et utiles |
| 4 hooks qui s'exécutent à chaque session et à chaque message | Non | Lisent les transcriptions, écrivent des fichiers |
| Journal local de coûts activé par défaut | Non | Données de session stockées sans demande |
| Webhook optionnel qui envoie le nom de la tâche par défaut | Non | Fuite possible de la première ligne de votre prompt (issue #1312) |
| Barre de statut avec `-ExecutionPolicy Bypass` | Non | Contourne une protection de Windows |

Sur les promesses : des tests indépendants (JetBrains, 80 tâches) mesurent environ **15 % de code en moins et 10 % de coût en moins**, loin des 54 % annoncés au départ. Utile, mais pas magique.

## Ce que nous avons ajouté

- Déclenchement en français : « fais simple », « version minimale », « pas d'usine à gaz ».
- **Aucune suppression de code, de test ou de fichier sans accord**, avec la liste de ce qui serait supprimé.
- Ligne de fin obligatoire : « Non fait / non vérifié » et « Risque ».
- Consigne pour les textes et documents (même esprit, sans retirer d'information demandée).

## Comment il travaille

1. Lire la tâche et le code touché, lister appelants, tests, configuration.
2. Prendre la première option qui marche : ne pas faire, réutiliser, bibliothèque standard, dépendance existante, une ligne, sinon le minimum.
3. Garder validations, gestion d'erreurs, sécurité et accessibilité.
4. Terminer par ce qui n'a pas été fait ou vérifié.

Trois niveaux : **léger** (propose la version minimale et vous laisse choisir), **normal**, **strict** (conteste aussi la demande).

## Exemples de demandes

- « Ajoute un bouton d'export CSV, fais simple. »
- « Mode minimal strict : j'ai besoin d'un script qui renomme mes photos par date. »
- « Ce code est une usine à gaz, simplifie sans rien casser. »

## Crédits

Adapté de [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail), © 2026 DietrichGebert, licence MIT (`LICENSE-ponytail`).
