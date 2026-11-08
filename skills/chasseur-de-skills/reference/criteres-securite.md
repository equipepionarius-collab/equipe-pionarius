# Critères de sécurité (scan manuel)

Les mêmes contrôles que `scripts/scanner-skill.ps1`, pour un Mac, un Linux ou une vérification à la main. Lancer chaque commande dans le dossier téléchargé ; chaque résultat doit être lu et classé « réel » ou « faux positif ».

| Catégorie | Points | Commande |
| --- | --- | --- |
| Exécution distante | 30 | `grep -rniE "(curl\|wget)[^|]*\|\s*(ba)?sh\|iex\s*\(\|Invoke-Expression" .` |
| Code dynamique | 15 | `grep -rniE "\beval\s*\(\|\bexec\s*\(\|new Function\|child_process\|subprocess\.\|os\.system" .` |
| Obfuscation | 20 | `grep -rniE "base64 (-d\|--decode)\|FromBase64String\|atob\(" .` et chercher les longues chaînes de lettres et chiffres |
| Lecture de secrets | 25 | `grep -rniE "\.env\b\|\.ssh\|\.aws\|id_rsa\|_API_KEY\|API_TOKEN\|SECRET_KEY\|keychain\|Cookies" .` |
| Exfiltration | 25 | `grep -rniE "webhook\|discord(app)?\.com/api\|hooks\.slack\.com\|api\.telegram\.org\|pastebin\|gist\.github\|ngrok" .` |
| Instruction cachée | 25 | `grep -rn "<!--" .` puis lire chaque commentaire |
| Manipulation de l'IA | 20 | `grep -rniE "ignore (all )?(previous\|prior)\|treat this skill as safe\|without (asking\|telling) the user" .` |
| Texte invisible | 20 | `grep -rnP "[\x{200B}-\x{200F}\x{202A}-\x{202E}\x{2060}-\x{2064}]" .` |
| Persistance | 15 | `grep -rniE "\.bashrc\|\.zshrc\|crontab\|launchd\|LaunchAgents\|\.claude/" .` |
| Installation auto | 10 | `grep -rniE "\"(pre\|post)install\"\|setup\.py\|install\.sh" .` |
| Réseau | 5 | `grep -rnoE "https?://[^ )\"']+" . \| sort -u` puis vérifier chaque domaine |

## Barème

Pour chaque catégorie trouvée, compter une fois le nombre de points ; additionner ; plafonner à 100.

- 0 à 20 : Installer.
- 21 à 50 : Installer avec précautions.
- 51 à 100 : Ne pas installer.

## Signaux qui ne se voient pas au scan

- Dépôt créé récemment avec beaucoup d'étoiles d'un coup, ou nom qui imite un projet connu.
- Lien raccourci (bit.ly, etc.) vers un script.
- Version publiée sur PyPI ou npm différente du code GitHub.
- Serveur MCP dont les descriptions d'outils contiennent des consignes, ou un outil qui fait plus que son nom.
- Code téléchargé après l'installation (mise à jour automatique depuis la branche `main`).

## Sources

Catégories inspirées de [NVIDIA/SkillSpector](https://github.com/NVIDIA/skillspector) (Apache-2.0).
