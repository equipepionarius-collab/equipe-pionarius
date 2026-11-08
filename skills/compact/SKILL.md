---
name: "compact"
description: "Quand l'utilisatrice écrit /compact, « compacte » ou « fais le ménage » dans n'importe quelle conversation : ranger, archiver le fait et ne garder que l'utile avant qu'elle tape /compact."
---

# Préparer un compactage (/compact)

Claude ne peut pas lancer /compact lui-même : seule l'utilisatrice peut taper la commande. Ce skill range le suivi de la conversation pour que le compactage ne perde rien d'utile.

Valable pour toutes les conversations du projet.

## Étapes

1. Lire la liste de suivi de la conversation dans le projet (liste datée, état, plan).
2. Archiver la version complète avant toute modification (copie locale ou doc projet daté `...-archive-AAAA-MM-JJ`).
3. Réécrire la liste en quatre blocs :
   - **Règles permanentes** : toutes les consignes encore valables, doublons fusionnés.
   - **État du jour** : ce qui est en cours ou programmé, avec les identifiants utiles.
   - **Actions datées** : seulement ce qui reste à faire.
   - **En attente**.
   Retirer : comptes rendus déjà faits, tâches terminées, détails techniques dépassés.
4. Mettre en tête la date de mise à jour et le nom de l'archive ; project_write.
5. Comparer avec l'archive : aucune consigne ni échéance future ne doit manquer.
6. Répondre en trois lignes : ce qui est archivé, ce qui est gardé, puis « Tu peux taper /compact, rien d'utile ne sera perdu. »

## Règles
- Ne jamais supprimer une consigne de l'utilisatrice ni une échéance future.
- Aucune action externe pendant le ménage.