# compact

> Ranger et archiver le suivi d'une conversation avant de taper `/compact`, pour que le compactage ne fasse perdre aucune consigne ni échéance.

## Le problème

`/compact` résume la conversation pour libérer de la place. Un résumé automatique peut laisser tomber une consigne ou une date. Ce skill range d'abord la liste de suivi, dont il garde une archive complète.

## Ce qu'il fait

1. Lit la liste de suivi de la conversation.
2. Archive la version complète avant toute modification (copie datée `…-archive-AAAA-MM-JJ`).
3. Réécrit la liste en quatre blocs :
   - **Règles permanentes** : toutes les consignes encore valables, doublons fusionnés ;
   - **État du jour** : en cours ou programmé, avec les identifiants utiles ;
   - **Actions datées** : seulement ce qui reste à faire ;
   - **En attente**.
   Il retire les comptes rendus déjà faits, les tâches terminées et les détails techniques dépassés.
4. Met en tête la date de mise à jour et le nom de l'archive, puis enregistre.
5. Compare avec l'archive : aucune consigne ni échéance future ne doit manquer.
6. Répond en trois lignes : ce qui est archivé, ce qui est gardé, puis « Tu peux taper /compact, rien d'utile ne sera perdu. »

## Exemples de demandes

- « /compact »
- « Compacte. »
- « Fais le ménage dans le suivi. »

## clear ou compact ?

| | [clear](../clear) | compact |
| --- | --- | --- |
| Objectif | Repartir d'une conversation vide | Continuer la même conversation, allégée |
| Fichier produit | Un état de reprise complet et autonome | La liste de suivi nettoyée, plus son archive |
| Après | Nouvelle conversation avec la phrase de reprise | `/compact`, puis on continue |

## Règles

- Ne jamais supprimer une consigne de l'utilisatrice ni une échéance future.
- Aucune action externe pendant le ménage.

## Compatibilité

Écrit pour les projets Claude (application) ; dans Claude Code, la liste de suivi et son archive sont des fichiers du dossier du projet.
