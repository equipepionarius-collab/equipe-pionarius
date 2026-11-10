# choix-modele-ia

> Choisir le bon modèle d'IA et le bon effort pour chaque tâche, estimer le coût réel, et vérifier une passerelle de modèles comme OmniRoute avant de l'installer.

## Pourquoi ce skill plutôt qu'OmniRoute

[OmniRoute](https://github.com/cheaper-inference/OmniRoute) (environ 86 000 étoiles, MIT) est une passerelle à héberger qui fait transiter vos prompts vers des centaines de fournisseurs. Ce n'est pas un skill, et nous ne recommandons pas de l'installer tel quel :

| Constat (novembre 2026) | Source |
| --- | --- |
| Faille **critique** d'exécution de code à distance, CVE-2026-88062, corrigée en 3.8.49 | Alertes de sécurité du dépôt |
| Fonction d'interception TLS avec installation d'un certificat racine | README du projet |
| Usurpation d'empreinte TLS pour échapper à la détection des fournisseurs | README du projet |
| Risque de suspension de compte (partage d'abonnements contraire aux conditions) | Forum Cursor, article Level Up Coding |
| Script `postinstall`, 110 outils MCP, tunnels publics possibles | `package.json`, README |
| Tous vos prompts et votre code passent par des tiers, parfois gratuits et inconnus | Fonctionnement même de l'outil |

Le skill garde ce qui est utile (payer moins cher, choisir le bon modèle) sans ces risques, et contient une **liste de vérification** pour qui veut quand même une passerelle.

## Ce qu'il fait

1. Associe chaque type de tâche au bon niveau de modèle et d'effort.
2. Estime le coût mensuel à partir des prix officiels du jour (jamais de mémoire).
3. Liste les économies sans risque : cache de prompts, contexte plus court, traitement par lots.
4. Vérifie une passerelle (OmniRoute, LiteLLM, proxy) : dépôt officiel, version sans faille connue, connexion obligatoire, écoute locale, pas de tunnel, pas de certificat racine, fournisseurs autorisés.

## Exemples de demandes

- « Quel modèle utiliser pour trier 2 000 e-mails par mois ? »
- « Combien me coûterait un agent qui rédige 30 articles par mois ? »
- « Une vidéo dit d'installer OmniRoute pour avoir des tokens gratuits : on fait ? »

## Crédits

Analyse de [cheaper-inference/OmniRoute](https://github.com/cheaper-inference/OmniRoute) (MIT). Aucun code repris.
