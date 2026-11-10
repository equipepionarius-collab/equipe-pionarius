# post-reseaux-gif

> Transformer un test ou des données réelles en post LinkedIn et Instagram, avec un carrousel animé en GIF, un appel à l'action par mot-clé et le guide à envoyer en réponse.

<p align="center"><img src="exemples/test-photos.gif" alt="Exemple de carrousel animé généré par le skill" width="320"></p>

## Pourquoi ce skill

Il vient d'un cas réel : refaire le test viral des « 214 856 photos supprimées retrouvées par l'IA » sur un iPhone, puis le raconter. Le skill reprend la méthode complète : des chiffres vérifiés, un récit honnête (échecs compris), un visuel animé qui montre l'expertise, et un mot-clé qui fait venir les prospects en message privé.

## Ce que vous recevez

| Livrable | Détail |
| --- | --- |
| Post LinkedIn | 1 300 à 2 000 caractères : accroche, contexte, résultats chiffrés, enseignements, conseil, question, appel à l'action, hashtags |
| Légende Instagram | Version courte avec « Commentez MOT-CLÉ » |
| Carrousel GIF | 800 × 1000 (4:5), en boucle, 8 à 10 diapos, compteurs et barres animés, aux couleurs de votre marque |
| Aperçus | Une image PNG par diapo, pour relire avant de publier |
| Guide de réponse | Le message à envoyer aux personnes qui écrivent le mot-clé |
| Sources | La liste des chiffres et de leur origine |

## Le générateur de carrousel

`scripts/carrousel-gif.ps1` fabrique le GIF à partir d'un fichier `diapos.json`. Aucun logiciel à installer sur Windows : il utilise les bibliothèques graphiques fournies avec le système.

8 types de diapos :

| Type | Ce qu'elle montre | Animation |
| --- | --- | --- |
| `accroche` | Grand chiffre + question | Aucune |
| `etapes` | Protocole avec ✓ et ✗ | Étapes révélées une à une |
| `chiffre` | Un ou deux résultats | Compteur de 0 au nombre |
| `barres` | Évolution ou répartition | Barres qui montent |
| `comparaison` | Deux colonnes, A contre B | Aucune |
| `liste` | Conseils numérotés | Aucune |
| `analyse` | L'avis de l'expert + pastilles | Aucune |
| `cta` | Mot-clé à envoyer | Aucune |

Exemple court :

```json
{
  "bandeau": "TEST RÉEL · IA & DONNÉES",
  "theme": { "accent": "#3B82F6" },
  "logo": "logo.png",
  "diapos": [
    { "type": "accroche", "grand": "214 856", "titre": "photos retrouvées grâce à l'IA ?", "texte": "J'ai refait le test.", "bas": "Résultat →" },
    { "type": "chiffre", "titre": "Sur mon iPhone", "nombre": 862, "legende": "fichiers visibles", "nombre2": "0", "legende2": "fichier supprimé retrouvé" },
    { "type": "cta", "titre": "Vous voulez faire le test ?", "etape1": "1. Demande de connexion", "etape2": "2. Écrivez-moi :", "mot_cle": "TEST PHOTO", "texte": "Je vous envoie le guide." }
  ]
}
```

```powershell
powershell -ExecutionPolicy Bypass -File scripts\carrousel-gif.ps1 -Diapos diapos.json -Sortie post.gif -Apercu apercu
```

Exemple complet (9 diapos, 46 secondes, 0,8 Mo) : [`exemples/test-photos.json`](exemples/test-photos.json).

## Exemples de demandes

- « Fais un post LinkedIn et un GIF façon carrousel Insta avec les résultats de ce test. »
- « Transforme ce rapport en carrousel animé aux couleurs de Pionarius, mot-clé AUDIT. »
- « Écris le message à envoyer aux gens qui commentent SCAN. »

## Garde-fous

- Uniquement des chiffres vrais et sourcés ; ce qui vient d'un tiers est attribué.
- Aucune donnée personnelle dans le texte ni dans le visuel.
- Brouillons uniquement : rien n'est publié, envoyé ni programmé sans votre accord pour ce post.
- Pas de copie de visuels ou de textes d'autres créateurs.

## Prérequis

- Windows 10 ou 11 pour le générateur de GIF (PowerShell 5.1, inclus).
- Facultatif : un outil de programmation de posts connecté à Claude, pour déposer les brouillons.

## Fichiers

| Fichier | Rôle |
| --- | --- |
| `SKILL.md` | La méthode : matière, post, carrousel, guide de réponse, livraison |
| `scripts/carrousel-gif.ps1` | Lit `diapos.json`, dessine les diapos, assemble le GIF animé |
| `scripts/carrousel.cs` | Moteur de dessin et d'animation (compilé à la volée par PowerShell) |
| `exemples/test-photos.json` | Le carrousel complet du test des photos supprimées |
| `exemples/test-photos.gif` | Le GIF obtenu avec ce fichier |

## Limites

- LinkedIn n'anime pas toujours les GIF ; le texte du post doit se suffire.
- Le générateur réduit la taille d'un texte trop long, mais un texte trop chargé reste moins lisible : une idée par diapo.
- Sur Mac, le script ne fonctionne pas ; le skill propose alors des images fixes ou un PDF.
