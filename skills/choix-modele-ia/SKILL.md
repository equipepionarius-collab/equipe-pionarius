---
name: choix-modele-ia
description: "Conseille le bon modèle d'IA et le bon niveau d'effort pour chaque tâche, estime le coût, et vérifie la sécurité d'une passerelle ou d'un routeur de modèles (OmniRoute, LiteLLM, OpenRouter, proxy local) avant de l'utiliser. À utiliser quand on demande « quel modèle prendre », « comment payer moins cher l'IA », « faut-il installer OmniRoute », « un proxy pour avoir des tokens gratuits »."
---

# Choisir son modèle d'IA et sa passerelle (pack Pionarius)

Dépenser moins sans mettre en danger ses données, ses comptes ni ses clients.

## Règles non négociables

1. **Prix et noms de modèles toujours vérifiés** sur la page officielle du fournisseur le jour même (ils changent souvent). Aucun prix de mémoire.
2. **Jamais de contournement des conditions d'utilisation** : pas de revente ou de partage d'abonnement, pas d'usurpation d'empreinte TLS, pas d'interception (MITM) avec un certificat racine installé, pas de « tokens gratuits » obtenus via les comptes d'autres personnes. Risque : suspension de compte et fuite de données.
3. **Aucune installation** de passerelle par Claude sans accord explicite après la vérification de l'étape 3.
4. **Données des clients** : savoir par quels serveurs passent les prompts avant d'y mettre des informations de clients (RGPD, secret professionnel).

## Étape 1 : Le bon modèle pour la tâche

| Type de tâche | Choix conseillé |
| --- | --- |
| Tri, extraction, reformulation, petites tâches répétées | Le plus petit modèle rapide de la gamme |
| Rédaction, analyse, code courant | Le modèle intermédiaire |
| Raisonnement long, architecture, audit difficile, agents autonomes | Le modèle le plus capable, effort élevé |
| Gros volumes non urgents | Traitement par lots si le fournisseur le propose |

Leviers d'économie sans risque : mise en cache des prompts, contexte plus court (ne pas recoller tout le projet), réponses plus courtes, effort adapté, traitement par lots.

## Étape 2 : Estimer le coût

Demander le volume (requêtes par jour, longueur moyenne entrée et sortie), lire les prix officiels du jour, calculer coût mensuel = requêtes × (jetons d'entrée × prix d'entrée + jetons de sortie × prix de sortie). Donner une fourchette et les hypothèses.

## Étape 3 : Vérifier une passerelle ou un routeur avant installation

Pour OmniRoute, LiteLLM, un proxy local ou tout outil qui fait transiter les prompts :

- [ ] Dépôt officiel identifié (OmniRoute a déménagé : `cheaper-inference/OmniRoute`, ancien nom `diegosouzapw/OmniRoute`) ; pas une copie.
- [ ] Version sans faille connue : consulter l'onglet « Security » du dépôt. Exemple : OmniRoute antérieur à 3.8.49 a une faille critique d'exécution de code à distance (CVE-2026-88062).
- [ ] Connexion obligatoire activée (`requireLogin` ou équivalent) et écoute limitée à `127.0.0.1`.
- [ ] Aucun tunnel public (ngrok, Cloudflare) sans nécessité.
- [ ] Aucun certificat racine installé, aucune fonction d'interception ou d'usurpation activée.
- [ ] Seulement des fournisseurs utilisés selon leurs conditions (OmniRoute marque lui-même certains fournisseurs « tos: avoid »).
- [ ] Scripts d'installation lus avant exécution (OmniRoute a un `postinstall`).
- [ ] Où sont stockés les journaux, les clés et les conversations, et pour combien de temps.

Verdict : « Utilisable », « Utilisable avec ces réglages », ou « À éviter », avec les raisons.

## Étape 4 : Recommandation

Le plus souvent, pour une petite structure : un seul fournisseur officiel, le bon modèle par tâche, la mise en cache et des prompts plus courts économisent plus, et plus sûrement, qu'une passerelle à 100 fournisseurs. Une passerelle se justifie pour plusieurs équipes, un suivi des coûts centralisé ou une bascule entre fournisseurs, en version à jour et bien réglée.

## Livrable

Tableau tâche → modèle → effort, estimation de coût datée avec ses sources, et, si une passerelle est envisagée, la liste de vérification remplie avec le verdict.

Inspiré de l'analyse de [cheaper-inference/OmniRoute](https://github.com/cheaper-inference/OmniRoute) (MIT) ; aucun code repris. Nous ne recommandons pas d'installer OmniRoute tel quel : faille critique corrigée récemment, interception TLS optionnelle, risques de violation des conditions des fournisseurs.
