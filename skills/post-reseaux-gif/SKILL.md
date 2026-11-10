---
name: post-reseaux-gif
description: "Transforme un test, une étude ou des chiffres réels en contenu prêt pour LinkedIn et Instagram, avec un post rédigé, un carrousel animé en GIF (format 4:5) aux couleurs de la marque, un appel à l'action par mot-clé (« écrivez TEST PHOTO ») et le guide à envoyer en réponse. À utiliser quand on demande « fais un post LinkedIn », « un GIF façon post Insta », « un carrousel avec mes données »."
---

# Post réseaux + carrousel GIF (pack Pionarius)

Produit un post qui montre une expertise réelle (test, analyse, conseils), à partir de données vérifiées, avec un visuel animé et un mécanisme de prise de contact.

## Règles non négociables

1. **Chiffres vrais uniquement.** Chaque nombre vient du test, d'un fichier ou d'une source citée. Ce qui vient d'un tiers est attribué (« selon le témoignage », « selon NVIDIA »). Rien n'est arrondi au point de changer le sens.
2. **Aucune donnée personnelle** dans le post ou le visuel : ni e-mail, ni nom d'appareil, ni nom de client non autorisé, ni capture contenant des informations privées.
3. **Brouillons seulement.** Claude ne publie rien, n'envoie aucun message et ne programme aucun post sans un accord explicite donné pour ce post précis. Avec un outil de programmation connecté (Zernio, Buffer…), créer des brouillons.
4. **Pas de copie** d'une marque, d'un visuel ou d'un texte tiers. Citer au plus une courte phrase, entre guillemets, avec la source.
5. **Pas de promesse** que l'outil ou l'IA ne tient pas : on montre ce qui a été obtenu, y compris les échecs.

## Étape 1 : Matière

Rassembler : le résultat principal en un chiffre, 3 à 5 faits chiffrés, ce qui a échoué ou surpris, la comparaison avec l'idée reçue (le témoignage viral, la promesse d'un outil), les conseils pratiques, l'expertise à mettre en avant (test réel, analyse de données, conseil, IA).

## Étape 2 : Post LinkedIn

Structure (1 300 à 2 000 caractères) :

1. **Accroche** sur 1 ou 2 lignes : le chiffre ou la promesse virale, puis « J'ai voulu vérifier ».
2. **Contexte** en 2 phrases.
3. **Ce que j'ai obtenu** : 3 lignes qui commencent par « → », chacune avec un chiffre.
4. **Ce que j'en retiens** : 3 points numérotés.
5. **Le conseil utile**, concret, faisable aujourd'hui.
6. **Question** au lecteur.
7. **Appel à l'action par mot-clé** : « Envoyez-moi une demande de connexion, puis écrivez-moi en message « MOT-CLÉ ». Je vous envoie… »
8. 4 à 6 hashtags.

Pour Instagram : même fond, une légende plus courte (800 caractères), l'appel à l'action « Commentez MOT-CLÉ ».

Passer le texte au skill `humanizer` s'il est installé.

## Étape 3 : Carrousel GIF

1. Écrire un fichier `diapos.json` (modèle complet : `exemples/test-photos.json`). 8 à 10 diapos, une idée par diapo :

   | Type | Usage | Champs |
   | --- | --- | --- |
   | `accroche` | Diapo 1 : grand chiffre + question | `grand`, `titre`, `texte`, `bas` |
   | `etapes` | Le protocole, révélé étape par étape, avec ✓ ou ✗ | `titre`, `sous_titre`, `items[{texte, ok}]` |
   | `chiffre` | Un résultat, avec compteur animé | `titre`, `nombre`, `legende`, `nombre2`, `legende2`, `note`, `anime` |
   | `barres` | Une évolution ou une répartition, barres animées | `titre`, `sous_titre`, `etiquettes[]`, `valeurs[]`, `accent` (index, -1 = dernière) |
   | `comparaison` | Deux colonnes (A contre B) | `titre`, `colonne_a`, `colonne_b`, `lignes[{critere, a, b}]`, `encart` |
   | `liste` | Conseils numérotés | `titre`, `sous_titre`, `items[]`, `numerote` |
   | `analyse` | L'avis de l'expert + pastilles d'expertise | `surtitre`, `titre`, `texte`, `fort`, `pastilles[]` |
   | `cta` | Dernière diapo : mot-clé | `titre`, `etape1`, `etape2`, `mot_cle`, `texte` |

   Réglages globaux : `bandeau`, `theme` (`fond`, `carte`, `texte`, `secondaire`, `accent` en hexadécimal), `logo` (chemin d'un PNG), `police`, `duree_secondes` (par défaut 4,5 ; aussi réglable par diapo).

2. Générer (Windows) :

   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts/carrousel-gif.ps1 -Diapos diapos.json -Sortie post.gif -Apercu apercu
   ```

   Sortie : un GIF 800 × 1000 en boucle, et, dans `apercu/`, une image PNG de chaque diapo terminée.

3. **Regarder chaque image d'aperçu** avant de livrer : texte coupé, chevauchement, faute, chiffre faux. Le script réduit la taille d'un texte trop long, mais un texte plus court reste la meilleure correction. Viser moins de 5 Mo.

Sans Windows : produire les mêmes diapos en images (une par diapo) et les assembler en GIF avec l'outil disponible, ou livrer un carrousel PDF.

## Étape 4 : Guide de réponse au mot-clé

Rédiger le message à envoyer aux personnes qui écrivent le mot-clé : remerciement d'une ligne, ce qu'il faut, les étapes numérotées, la version « avec une IA », le lien utile (dépôt, ressource), « répondez à ce message si vous bloquez ».

## Étape 5 : Livrer

- le post LinkedIn et la légende Instagram, prêts à copier ;
- le GIF et ses aperçus ;
- le guide de réponse ;
- la liste des chiffres et de leur source, pour vérification ;
- si un outil de programmation est connecté : les brouillons créés, avec leur lien, et rien de publié.

LinkedIn affiche parfois un GIF sans animation : le texte du post doit fonctionner seul.
