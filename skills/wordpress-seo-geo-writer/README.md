# wordpress-seo-geo-writer

> Rédiger un article prêt à coller dans WordPress, optimisé à la fois pour Google (SEO) et pour être cité par les moteurs de recherche IA (GEO : ChatGPT Search, Google AI Overviews, Perplexity).

## Ce qu'il fait

| Étape | Ce que Claude fait |
| --- | --- |
| 1. Cadrer | Sujet, intention de recherche, mot-clé principal et 3 à 6 secondaires, cible, zone, longueur (1 000 à 1 500 mots par défaut), ton. Il ne demande que ce qui manque, et valide les mots-clés avec un outil (Semrush, recherche web) quand il y en a un |
| 2. Structurer pour le SEO | Balise title ≤ 60 caractères, méta-description de 140 à 160 caractères, slug court, un seul H1, H2/H3 logiques, réponse dès l'introduction, 2 à 4 liens internes, 1 à 2 liens externes, textes alternatifs des images |
| 3. Optimiser pour le GEO | Une phrase-réponse autonome en tête de chaque section, listes et tableaux, données concrètes, FAQ de 3 à 6 questions, sources datées |
| 4. Balisage | Bloc JSON-LD `Article`, `FAQPage` si une FAQ existe, `LocalBusiness` seulement pour un sujet local aux coordonnées connues |
| 5. Livrer | Un fichier HTML propre (sans style intégré) avec title, méta-description, slug et JSON-LD, plus une liste de vérifications avant publication |

## Exemples de demandes

- « Écris un article sur la facturation électronique obligatoire pour les TPE. »
- « Un billet de blog sur l'audit IA pour les cabinets comptables, mot-clé “audit IA cabinet comptable”. »
- « Article local : choisir un consultant IA à Paris. »

## Ce que vous recevez

- Un fichier `.html` à coller dans l'éditeur WordPress (bloc HTML personnalisé ou éditeur de code).
- En tête : title, méta-description et slug proposés.
- Le bloc JSON-LD à coller dans l'article ou dans le champ de schéma de votre extension SEO.
- Une courte liste à vérifier : mots-clés à valider, liens internes à renseigner, image à ajouter.

## Règles

- Contenu factuel : aucune statistique ni citation inventée ; ce qui doit être vérifié est signalé.
- Écrire d'abord pour le lecteur : l'optimisation ne doit jamais rendre le texte moins lisible.
- Langue de la demande, français par défaut.

## Conseils

- Associez-le au skill [humanizer](../humanizer) pour une dernière relecture du style.
- Pour publier et régler les balises Rank Math, enchaînez avec [webmaster-wordpress-elementor](../webmaster-wordpress-elementor).

## Limites

- Sans outil de mots-clés, les volumes de recherche ne sont pas vérifiés : le skill le signale.
- Les URL des liens internes sont des emplacements à compléter quand Claude ne les connaît pas.
