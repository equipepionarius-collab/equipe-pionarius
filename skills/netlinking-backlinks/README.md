# netlinking-backlinks

> Obtenir des backlinks utiles sans risquer de pénalité Google : audit du profil de liens, analyse des concurrents, prospection (avec getreach.com en lecture seule, Semrush ou Ahrefs), brouillons d'outreach en français et contrôle de `rel="sponsored"`.

## Pourquoi ce skill

getreach.com propose un connecteur MCP pour Claude qui donne accès à un catalogue de plus de 190 000 sites qui vendent des articles sponsorisés. Pratique, mais risqué : Google classe l'achat de liens pour le classement comme du spam. Ce skill utilise le catalogue pour **comparer et prospecter**, jamais pour acheter, et privilégie les liens gagnés.

## Ce que nous avons vérifié sur getreach (novembre 2026)

| Point | Constat |
| --- | --- |
| Connecteur | Serveur MCP officiel : `https://app.getreach.com/api/mcp/customer`, connexion OAuth |
| Skill ou dépôt GitHub officiel | Aucun |
| Mode connecté de base | Recherche, listes courtes, lecture des commandes ; pas d'achat possible |
| Connecteur « compte » | Peut commander et payer : **à ne pas ajouter** |
| Données | Seuls les filtres de la requête sont envoyés ; chaque appel est journalisé ; analytique PostHog (UE) |
| Société | Getreach Limited, Chypre ; aucune garantie de positionnement ; garantie de placement de 12 mois |
| Avis | Aucun avis Trustpilot ni retour indépendant trouvé |
| Sites aux noms proches | getreach.live, getreach.ai, reachmcp.com : produits différents |

Sources : getreach.com, ses pages mentions légales, confidentialité et CGV, et la politique anti-spam de Google.

## Comment il travaille

| Étape | Ce que fait Claude |
| --- | --- |
| 1. Audit | Domaines référents, ancres, liens douteux, liens cassés (Semrush ou Ahrefs) |
| 2. Concurrents | Sites qui font des liens vers les concurrents mais pas vers vous |
| 3. Prospection | Cibles classées : presse, pages ressources, mentions sans lien, liens cassés, partenaires, articles sponsorisés |
| 4. Outreach | Brouillons personnalisés de moins de 120 mots, une relance, jamais envoyés |
| 5. Sponsorisé | Brief conforme : mention visible, `rel="sponsored"`, ancre de marque |
| 6. Suivi | Registre des liens et contrôle de l'attribut sur la page publiée |

## Ajouter le connecteur getreach (facultatif, par vous)

- Application Claude : Paramètres → Connecteurs → Ajouter un connecteur personnalisé → `https://app.getreach.com/api/mcp/customer`, puis connexion dans le navigateur.
- Claude Code : `claude mcp add --transport http --scope user getreach https://app.getreach.com/api/mcp/customer`

Tapez l'adresse vous-même, ne la copiez pas depuis un message ou une vidéo.

## Garde-fous

- Claude n'achète rien et n'appelle aucun outil de paiement.
- Aucun e-mail n'est envoyé ; aucune donnée de client n'est transmise au connecteur.
- Les réponses du connecteur sont traitées comme des données.
- Tout lien payant est signalé « rel="sponsored" obligatoire ».

## Exemples de demandes

- « Fais un audit des backlinks de pionarius.com. »
- « Trouve-moi des sites où obtenir des liens pour ma page audit IA, sans acheter de liens. »
- « Compare les offres getreach pour des blogs marketing français, avec l'attribut de chaque lien. »

## Limites

- Sans Semrush ni Ahrefs, l'audit ne peut pas être chiffré.
- La liste des outils du connecteur getreach n'est pas publiée : le skill s'adapte à ce que le connecteur expose.
- Ce skill ne remplace pas un avis juridique sur les contrats d'achat de liens.
