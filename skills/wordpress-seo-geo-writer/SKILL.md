---
name: wordpress-seo-geo-writer
description: "Rédiger un article WordPress optimisé SEO (Google) et GEO (citation par les IA de recherche). Utiliser quand on demande un article, un billet de blog ou du contenu web à publier sur WordPress."
---

# Rédacteur WordPress SEO + GEO

Produire un article web complet, prêt à coller dans WordPress, optimisé à la fois pour le référencement Google (SEO) et pour la citation par les moteurs de recherche IA (GEO : ChatGPT Search, Google AI Overviews, Perplexity).

## Étape 1 — Cadrer le sujet

Avant de rédiger, établir (demander à l'utilisateur seulement ce qui manque et qu'on ne peut pas déduire) :
- Le **sujet** et l'**intention de recherche** (informationnelle, transactionnelle, locale).
- Le **mot-clé principal** et 3 à 6 **mots-clés secondaires** / requêtes associées.
- La **cible** (grand public, professionnels) et la **zone géographique** si le sujet est local.
- La **longueur** visée (par défaut 1000–1500 mots) et le **ton**.

Si l'utilisateur ne fournit pas les mots-clés, les proposer à partir du sujet. Quand un outil de recherche de mots-clés est disponible (Semrush, recherche web), l'utiliser pour valider volume et concurrence avant de rédiger. Sinon, le signaler : « À vérifier avec un outil de mots-clés avant publication. »

## Étape 2 — Structurer pour le SEO

- **Title (balise title)** : ≤ 60 caractères, mot-clé principal au début.
- **Méta-description** : 140–160 caractères, incitative, contient le mot-clé principal.
- **URL / slug** : court, en minuscules, avec le mot-clé, sans mots vides.
- **Un seul H1** = le titre de l'article. Sous-titres en H2/H3 logiques, contenant les mots-clés secondaires quand c'est naturel.
- **Introduction** : répondre à l'intention dès les 2–3 premières phrases (ne pas « tourner autour »).
- **Maillage** : suggérer 2–4 liens internes pertinents (placeholders si les URL exactes sont inconnues) et 1–2 liens externes vers des sources faisant autorité.
- **Densité** : mot-clé principal utilisé naturellement, jamais en bourrage.
- **Alt text** : proposer un attribut alt descriptif pour chaque image suggérée.

## Étape 3 — Optimiser pour le GEO (citation par les IA)

Les moteurs IA citent les contenus **factuels, structurés et directement répondants**. Donc :
- Ouvrir chaque section par une **phrase-réponse autonome** (une affirmation claire et citable, compréhensible hors contexte).
- Préférer des **listes, tableaux et définitions** aux longs paragraphes.
- Inclure des **données concrètes** (chiffres, délais, étapes, seuils) plutôt que des généralités.
- Ajouter une **section FAQ** (3–6 questions) reprenant les formulations réelles des utilisateurs, avec des réponses courtes et directes.
- Citer les **sources et dates** quand une affirmation repose sur des faits vérifiables.

## Étape 4 — Balisage structuré (JSON-LD)

Fournir un bloc `<script type="application/ld+json">` à coller dans l'article :
- `Article` (headline, description, author, datePublished).
- `FAQPage` si une FAQ est présente.
- `LocalBusiness` uniquement si le sujet est local et que les coordonnées sont connues.

## Étape 5 — Livrer

Sortie par défaut : **un fichier HTML propre** (titres Hn, `<p>`, `<ul>`, `<table>`, sans styles inline) copiable-collable dans l'éditeur WordPress, plus, en tête du fichier ou en commentaire :
- Title proposé
- Méta-description
- Slug proposé
- Le bloc JSON-LD

Livrer le fichier via SendUserFile (ou l'écrire dans le dossier de sortie). Terminer par une courte checklist à vérifier avant publication : mots-clés à valider, liens internes à renseigner, image à ajouter.

## Règles

- Contenu **factuel et honnête** : ne pas inventer de statistiques ni de citations. Marquer clairement ce qui doit être vérifié.
- Écrire pour l'humain d'abord ; l'optimisation ne doit jamais dégrader la lisibilité.
- Respecter la langue de la demande (français par défaut).