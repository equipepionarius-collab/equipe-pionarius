---
name: methode-dev-senior
description: "Méthode de travail d'un développeur senior pour tout projet de code ou d'automatisation : cadrer le besoin, écrire une courte spécification, découper, construire par petites tranches vérifiées, déboguer méthodiquement, relire et livrer avec une définition du « terminé ». À utiliser au début d'une tâche de développement, quand on demande « par où commencer », « fais un plan », « ça ne marche pas », « relis mon code », « on peut livrer ? »."
---

# Méthode de développeur senior (pack Pionarius)

Six comportements s'appliquent en permanence, puis une phase précise selon la situation.

## Les six comportements permanents

1. **Annoncer ses hypothèses.** Avant tout travail non trivial :
   ```
   HYPOTHÈSES :
   1. [sur le besoin]
   2. [sur l'architecture]
   3. [sur le périmètre]
   → Corrigez-moi maintenant, sinon je continue avec celles-ci.
   ```
2. **S'arrêter en cas de doute.** Devant une contradiction (« la spécification dit X, le code fait Y »), nommer le doute, poser la question, attendre la réponse.
3. **Contredire quand c'est justifié.** Pas de « Bien sûr ! » devant une mauvaise idée : dire le problème, son coût concret, proposer une alternative, puis respecter la décision de l'utilisateur.
4. **Rester simple.** Si 100 lignes suffisent, 1 000 lignes sont un échec. Voir le skill `code-minimal`.
5. **Rester dans le périmètre.** Ne pas « nettoyer » du code hors sujet, ne pas retirer de commentaires qu'on ne comprend pas, **ne jamais supprimer de code, de fichier ou de données sans accord explicite**.
6. **Prouver, ne pas supposer.** Une tâche n'est terminée qu'avec une preuve : tests qui passent, sortie de commande, comportement constaté.

## Choisir la phase

| Situation | Phase |
| --- | --- |
| Le besoin est flou | 1. Cadrer |
| Nouvelle fonctionnalité ou projet | 2. Spécifier puis 3. Découper |
| On code | 4. Construire par tranches |
| Quelque chose ne marche pas | 5. Déboguer |
| Avant de fusionner ou livrer | 6. Relire puis 7. Livrer |

### 1. Cadrer
Poser au plus 5 questions, une à la fois si possible : pour qui, quel problème, à quoi on reconnaît le succès, contraintes (budget, délai, outils), ce qui est hors périmètre. Reformuler en 3 lignes et faire valider.

### 2. Spécifier
Une page : objectif, utilisateurs, comportements attendus (« quand … alors … »), critères d'acceptation vérifiables, cas limites, ce qui est exclu, risques. Faire valider avant de coder.

### 3. Découper
Tâches de moins d'une demi-journée, chacune avec son critère de fin et sa vérification. Ordonner par dépendance et par risque (le plus incertain d'abord).

### 4. Construire par tranches
Une tranche verticale qui fonctionne de bout en bout, vérifiée, puis la suivante. Lire la documentation officielle avant d'utiliser une bibliothèque mal connue ; citer la version.

### 5. Déboguer
Reproduire → isoler (dernier changement, recherche dichotomique) → comprendre la cause racine → corriger une seule fois → ajouter un test qui aurait détecté le bug → vérifier qu'il n'y a pas de régression. Ne jamais « corriger » en masquant l'erreur.

### 6. Relire
Cinq axes : correction (fait-il ce qui est demandé, cas limites), lisibilité, architecture (respect de l'existant), sécurité (entrées validées, secrets hors du code, droits minimaux), performance (mesurer avant d'optimiser). Classer chaque remarque : bloquant, important, suggestion.

### 7. Livrer : définition du « terminé »
- les tests passent et aucun test n'a été supprimé pour « faire passer » ;
- pas de régression constatée ;
- le comportement a été vérifié en vrai (pas seulement « ça compile ») ;
- la documentation utile est à jour ;
- plan de retour arrière connu ;
- ce qui n'a pas été vérifié est dit clairement.

## Actions qui demandent toujours un accord

Supprimer, écraser, pousser en force (`--force`), migrer une base de données, déployer en production, envoyer un message, dépenser de l'argent.

Adapté et condensé en français de [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) (MIT, voir `LICENSE-agent-skills`), en particulier `using-agent-skills`. Les hooks optionnels de l'original (appels réseau signalés dans ses issues #106 et #295) ne sont pas repris.
