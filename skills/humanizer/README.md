# humanizer

> Réécrire un texte qui « sonne IA » pour qu'il sonne comme son auteur, sans changer ce qu'il dit et sans rien inventer.

Adapté de [blader/humanizer](https://github.com/blader/humanizer) (licence MIT, © 2025 Siqi Chen). Les règles s'appuient sur la page Wikipédia [« Signs of AI writing »](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing). Le fichier `SKILL.md` est en anglais ; il fonctionne sur des textes en français comme dans toute autre langue.

## Comment il travaille

1. **Repérer les tics** sur tout le texte, du plus fort au plus faible.
2. **Rédiger une réécriture** qui garde chaque affirmation, sans ajouter ni fait, ni nom, ni chiffre, ni citation.
3. **Contrôler** : relire à voix haute, vérifier qu'aucune information n'a été ajoutée ou perdue, chercher les tics qui survivent le plus souvent.
4. **Livrer la version finale**, avec des phrases de longueurs variées.

## Les 26 tics repérés, en 6 familles

| Famille | Exemples |
| --- | --- |
| A. Mise en scène au lieu d'affirmer | « Ce n'est pas X, c'est Y », phrases-chutes d'une ligne, maximes creuses, « Plongeons dans… », réponses à des objections que personne n'a faites |
| B. Rythme mécanique | Énumérations par trois, débuts de phrase répétés, tirets cadratins partout, précautions empilées |
| C. Emphase et autorité empruntée | Mots typiques des IA, importance gonflée, ton publicitaire, « les experts disent… », « sert de » au lieu de « est » |
| D. Mise en forme systématique | Gras décoratif, titres à majuscules et émojis, guillemets courbes |
| E. Restes de conversation | « J'espère que cela vous aide ! », avertissements sur les limites du modèle, texte qui parle de lui-même |
| F. Mauvais lecteur | Réponse qui réexplique tout le contexte avant d'arriver à la décision |

Les tics 1 à 5 justifient une correction dès la première occurrence ; les tics marqués « faibles seuls » n'en justifient une qu'avec d'autres indices.

## Trois façons de l'utiliser

| Mode | Quand | Ce que vous recevez |
| --- | --- | --- |
| Texte collé (par défaut) | Vous collez un texte | Le brouillon, la liste des tics restants, la version finale |
| Fichier | Vous nommez un fichier | Le fichier corrigé (code, liens et métadonnées intacts) et un court résumé |
| Intégré | Un autre travail l'appelle (article, message de commit) | Seulement le texte final |

## La voix

- Avec un **exemple de votre écriture**, Claude imite votre longueur de phrase, votre vocabulaire et votre ponctuation, tirets compris si vous en utilisez.
- Sans exemple, il garde opinions, humour et nuances pour un billet ou un texte personnel, et reste neutre pour un texte technique ou juridique.

## Exemples de demandes

- « Humanise ce post LinkedIn. »
- « Relis cet article et enlève tout ce qui fait IA. »
- « Voici trois de mes anciens posts : réécris celui-ci dans le même style. »

## Limites

- Il ne rend pas un texte « indétectable » : il le rend plus clair et plus personnel.
- Un texte écrit avant le 30 novembre 2022 n'est pas considéré comme écrit par une IA.
- Citations, titres et noms propres ne sont pas modifiés.
