# clear

> Tout sauvegarder avant de taper `/clear`, pour qu'une nouvelle conversation reprenne le travail exactement où il s'était arrêté.

## Le problème

La commande `/clear` vide la conversation. Claude ne peut pas la lancer lui-même, et tout ce qui n'a pas été écrit quelque part est perdu : consignes, état d'avancement, échéances. Ce skill fait le point juste avant, dans un fichier de reprise.

## Ce qu'il fait

1. Trouve la liste de suivi de la conversation, ou en crée une : `claude/etat-<sujet>.md`.
2. Y écrit un état de reprise complet :
   - **Règles et consignes** données, y compris les « ne pas faire » ;
   - **État actuel** : fait, livré, programmé, en cours, avec liens, identifiants et chemins ;
   - **Actions datées restantes**, de la plus proche à la plus lointaine ;
   - **En attente** : réponses et validations ;
   - **Comment reprendre** : la phrase à dire dans la nouvelle conversation.
3. Archive l'ancienne version du fichier avec la date, puis enregistre la nouvelle.
4. Relit le fichier pour vérifier qu'aucune consigne ni échéance n'a disparu.
5. Répond en trois lignes : où l'état est sauvegardé, la phrase de reprise, puis « Tu peux taper /clear. »

## Exemples de demandes

- « /clear »
- « On repart à zéro. »
- « Prépare-moi un clear, je change de sujet. »

## Exemple de réponse

```
État sauvegardé dans claude/etat-site-web.md (ancienne version archivée).
Pour reprendre : « lis claude/etat-site-web.md puis fais ce que tu as à faire ».
Tu peux taper /clear.
```

## Règles

- Aucune action externe (envoi, publication, suppression) pendant ce skill.
- Ne jamais résumer une consigne au point d'en changer le sens.

## Compatibilité

Écrit pour les projets Claude (application) ; dans Claude Code, le fichier d'état est écrit dans le dossier du projet. Voir aussi [compact](../compact), pour alléger sans repartir de zéro.
