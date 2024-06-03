# fluffy-DNSenum - PowerShell DNS Enumeration Script

## Description 
fluffy-DNSenum est un script PowerShell qui permet d'effectuer une énumération DNS complète sur un domaine spécifié. Il récupère les enregistrements DNS courants (A, MX, NS, SOA, TXT) et peut tenter de découvrir des sous-domaines à l'aide d'un fichier de liste de mots.

## Prérequis

- PowerShell 5.1 ou supérieur
- Un fichier de liste de mots pour le brute force des sous-domaines (optionnel)

## Fonctionnalités

- Énumération des enregistrements DNS pour les types A, MX, NS, SOA, et TXT.
- Brute force des sous-domaines à partir d'un fichier de liste de mots.

## Installation

1. Téléchargez le script `fluffy-DNSenum.ps1` et sauvegardez-le dans un répertoire de votre choix.

2. (Optionnel) Préparez un fichier de liste de mots pour le brute force des sous-domaines. Par exemple, `subdomains.txt`.

## Utilisation

Ouvrez PowerShell et exécutez le script avec les paramètres nécessaires :

```powershell
.\fluffyDNSenum.ps1 -domain example.com -wordlistPath subdomains.txt
```

## Paramètres
- `-domain` (obligatoire) : Le domaine à énumérer.

- `-wordlistPath` (optionnel) : Chemin vers le fichier de liste de mots pour le brute force des sous-domaines (par défaut subdomains.txt).

## Sortie
Le script affichera les enregistrements DNS trouvés pour les types `A, MX, NS, SOA, et TXT.` Si un fichier de liste de mots est fourni, il affichera également les `sous-domaines découverts et leurs adresses IP correspondantes`.


# Avertissements
- Utilisez ce script uniquement sur des domaines que vous possédez ou pour lesquels vous avez une autorisation explicite d'effectuer des tests.

- L'utilisation de ce script sur des domaines sans autorisation peut être illégale et est contraire aux politiques de nombreuses organisations.

# Clause de Non-Responsabilité
Ce script est fourni à des fins éducatives et de test uniquement. L'auteurice décline toute responsabilité pour tout dommage ou conséquence découlant de l'utilisation de ce script. L'utilisation de ce script à des fins malveillantes est strictement interdite. Vous êtes seul responsable de l'utilisation de ce script conformément aux lois et réglementations locales, nationales et internationales.


## Auteurice
`Potite_Bulle (bashx00 · Interface)`

## Licence
Ce projet est sous `licence MIT`. Voir le fichier [LICENSE](https://github.com/bashx00/fluffy-DNSenum/blob/main/LICENSE) pour plus de détails.