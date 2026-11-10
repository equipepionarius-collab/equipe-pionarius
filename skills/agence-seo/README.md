# agence-seo

> Une agence SEO et GEO complète pour n'importe quel site, adaptée à son secteur : compréhension du métier, audit, requêtes du secteur, optimisation, contenus, fiche locale, liens, mesure. Chaque texte passe par **humanizer** pour sonner humain.

## Pourquoi ce skill

Les autres skills du pack font chacun une partie du travail. Celui-ci les enchaîne comme le ferait une agence, en commençant par ce que les outils oublient souvent : **le secteur du client**. Un cabinet d'avocats, un restaurant et une boutique en ligne n'ont ni les mêmes requêtes, ni les mêmes règles de communication, ni les mêmes pages à créer.

## Comment il travaille

| Étape | Ce que fait Claude | Skill utilisé |
| --- | --- | --- |
| 1. Secteur | Métier, clientèle, zone, conversion, concurrents, vocabulaire des clients, règles du secteur | — |
| 2. Audit | Score sur 100, 3 actions prioritaires, contrôles du secteur | `audit-seo-geo` |
| 3. Requêtes | Intentions du secteur, volumes si un outil est connecté, une requête par page | — |
| 4. Optimisation | Balises, structure, données structurées du métier, maillage, images, vitesse | `webmaster-wordpress-elementor` ou `seo-pilote-quotidien` |
| 5. Contenus | Calendrier de 3 mois, pages de services et de zone, articles | `wordpress-seo-geo-writer` |
| 6. Humanizer | Chaque texte public réécrit pour sonner humain, sans rien inventer | `humanizer` |
| 7. Local | Google Business Profile, NAP, annuaires du secteur, réponses aux avis en brouillon | — |
| 8. Liens | Partenaires, associations, presse du secteur | `netlinking-backlinks` |
| 9. Mesure | Avant, J+14, rapport mensuel | — |

## Où il fonctionne

- **Site ouvert dans Chrome** (avec Claude in Chrome) : WordPress, Elementor, Rank Math. Vous vous connectez vous-même à l'administration ; Claude prépare et applique après votre accord.
- **Site dont le code est dans un dépôt** : modifications en propositions à valider.
- **Wix, Shopify, Webflow** : liste de modifications prête à appliquer, page par page.

## Règles par secteur intégrées

Santé et bien-être (pas de promesse de guérison), professions réglementées (déontologie sur la publicité), immobilier et finance (mentions obligatoires), alcool (loi Évin), commerce local (fiche Google à jour), e-commerce (prix TTC, conditions). En cas de doute : « à valider par un professionnel du secteur ».

## Exemples de demandes

- « Fais le SEO complet de www.mon-client.fr, c'est un cabinet de kinésithérapie à Lyon. »
- « Agence SEO sur ce site WordPress ouvert dans Chrome. »
- « Optimise tout le site de la boulangerie, avec des textes qui ne font pas IA. »

## Garde-fous

- Rien n'est publié sans votre accord ; vous saisissez vous-même vos mots de passe.
- Aucun chiffre, avis, prix ou référence inventé.
- White hat uniquement ; règles du secteur respectées.
- Aucune page avec du trafic supprimée ou redirigée sans accord.

## Prérequis

- Le skill `humanizer` (inclus dans ce dépôt) ; sans lui, une version minimale des règles s'applique.
- Recommandé : Search Console, Semrush ou Ahrefs connectés pour des chiffres réels.
- Pour agir sur un site en ligne : Claude in Chrome.

## Crédits

Création Équipe Pionarius. S'appuie sur les autres skills du dépôt, dont `humanizer` (adapté de [blader/humanizer](https://github.com/blader/humanizer), MIT).
