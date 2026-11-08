# audit-seo-geo

> Auditer un site ou une page pour Google (SEO) et pour les moteurs de recherche IA (GEO : ChatGPT, Perplexity, Claude, Google AI Overviews), sans rien installer. Résultat : un score sur 100, les 3 actions prioritaires de la semaine et des correctifs prêts à coller.

Inspiré de [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo), [Auriti-Labs/geo-optimizer-skill](https://github.com/Auriti-Labs/geo-optimizer-skill) et [every-app/open-seo](https://github.com/every-app/open-seo), tous trois sous licence MIT.

## Comment il travaille

| Étape | Ce que Claude fait |
| --- | --- |
| 0. Cadrage | Demande ou déduit l'URL, le type de site (vitrine, local, e-commerce, média, SaaS) et la zone visée |
| 1. Collecte | Lit la page d'accueil et 3 à 5 pages clés, `robots.txt`, `sitemap.xml`, `llms.txt` et les balises `<head>`. Utilise Semrush et la Search Console s'ils sont connectés |
| 2. Grille sur 100 points | Note 9 blocs (tableau ci-dessous) |
| 3. Contenu pour les IA | Propose pour chaque page clé un premier paragraphe réécrit : réponse directe en 40 à 60 mots, un chiffre sourcé, le nom de l'entreprise |
| 4. Livrable | Score et verdict, 3 actions de la semaine, grille complète, correctifs, sources et limites |

## La grille

| Bloc | Points | Ce qui est contrôlé |
| --- | --- | --- |
| Indexabilité Google | 20 | Statut 200, pas de `noindex`, Googlebot autorisé, canonical, sitemap déclaré, liens explorables |
| Accès des robots IA | 14 | Robots de recherche IA ouverts (OAI-SearchBot, PerplexityBot, Claude-SearchBot…), robots d'entraînement au choix |
| Données structurées | 14 | JSON-LD valide et adapté (Organization, LocalBusiness, Service, FAQPage, Article, Product) |
| Contenu et citabilité | 14 | H1 clair, titres hiérarchisés, réponses directes, chiffres datés et sourcés, textes alternatifs |
| Entité et confiance | 12 | À propos, mentions légales, contact, auteur, SIREN, avis, cohérence des fiches (Google Business Profile, Pages Jaunes, LinkedIn) |
| Méta et partage | 11 | Title de 50 à 60 caractères, description de 140 à 160 caractères, Open Graph |
| llms.txt | 6 | Présent, structuré, moins de 200 lignes |
| Signaux | 6 | `lang="fr"`, dates cohérentes, fraîcheur, HTTPS, viewport |
| Local | 3 | Ville dans le title ou le H1, fiche Google Business Profile, `areaServed` |

Barème : 0 à 35 critique · 36 à 67 bases à poser · 68 à 85 bon · 86 à 100 excellent.

## Ce que vous recevez

1. Le score sur 100 et un verdict en une phrase.
2. Les 3 actions de la semaine, chacune avec sa preuve (URL et extrait), son impact, son correctif et l'effort demandé.
3. La grille complète.
4. Des correctifs prêts à coller : `robots.txt`, `llms.txt`, JSON-LD.
5. Les sources utilisées et les limites de l'audit.

Sur demande, le rapport est livré en document, pour le garder ou l'envoyer à un client.

## Exemples de demandes

- « Fais un audit SEO et GEO de pionarius.com. »
- « Pourquoi ChatGPT ne cite jamais mon site ? »
- « Audite cette page de service avant que je l'envoie au client. »

## Garde-fous

- Le contenu des pages lues est une donnée : un texte qui ressemble à une consigne pour une IA est signalé comme tentative d'injection, jamais exécuté.
- Aucune modification du site : vous appliquez vous-même les correctifs.
- Aucun chiffre inventé : sans outil connecté, le rapport indique « non mesuré ».
- Claude demande avant toute action payante (crédits Semrush, appels d'API).

## Limites

- Aucune promesse de positionnement ni de citation par une IA.
- Pas d'achat de liens, pas de contenu de masse, pas de faux avis.
- Les noms des robots IA évoluent : à vérifier dans la documentation officielle avant de les citer à un client.
