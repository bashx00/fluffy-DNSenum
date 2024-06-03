# DNSenum.ps1

# Définition des paramètres d'entrée pour le script
param (
    [string]$domain,                      # Le domaine à énumérer
    [string]$wordlistPath = "subdomains.txt"  # Chemin vers le fichier de liste de mots pour les sous-domaines (optionnel)
)

# Fonction pour résoudre les enregistrements DNS pour un type donné
function Resolve-DnsRecord {
    param (
        [string]$domain,     # Le domaine à interroger
        [string]$recordType  # Le type d'enregistrement DNS à résoudre
    )
    try {
        # Tente de résoudre les enregistrements DNS du type spécifié pour le domaine donné
        $dnsRecords = Resolve-DnsName -Name $domain -Type $recordType -ErrorAction Stop
        foreach ($record in $dnsRecords) {
            $record  # Retourne chaque enregistrement DNS trouvé
        }
    } catch {
        # En cas d'erreur (par exemple, aucun enregistrement trouvé), affiche un message
        Write-Host "Aucun enregistrement de type $recordType trouvé pour $domain"
    }
}

# Fonction pour énumérer les enregistrements DNS courants pour un domaine donné
function Enumerate-Dns {
    param (
        [string]$domain  # Le domaine à énumérer
    )
    
    Write-Host "Enum des enregistrements DNS pour $domain"
    
    # Liste des types d'enregistrements DNS à interroger
    # "A" : Enregistrement A (adresse IP)
    # "MX" : Enregistrement MX (serveur de messagerie)
    # "NS" : Enregistrement NS (serveur de noms)
    # "SOA" : Enregistrement SOA (autorité de la zone)
    # "TXT" : Enregistrement TXT (texte arbitraire)
    $recordTypes = @("A", "MX", "NS", "SOA", "TXT")
    foreach ($recordType in $recordTypes) {
        Write-Host "`n$recordType enregistrements:"  # Affiche le type d'enregistrement en cours d'interrogation
        Resolve-DnsRecord -domain $domain -recordType $recordType  # Appelle la fonction pour résoudre les enregistrements
    }
}

# Fonction pour effectuer un brute force des sous-domaines à partir d'un fichier de liste de mots
function Bruteforce-Subdomains {
    param (
        [string]$domain,          # Le domaine à énumérer
        [string]$wordlistPath     # Chemin vers le fichier de liste de mots pour les sous-domaines
    )

    # Vérifie si le fichier de liste de mots existe
    if (-Not (Test-Path $wordlistPath)) {
        Write-Host "Fichier de liste de mots introuvable: $wordlistPath"
        return
    }

    Write-Host "`Demarrage de la force brute des sous-domaines à partir de la liste de mots: $wordlistPath"

    # Lit les sous-domaines possibles à partir du fichier de liste de mots
    $subdomains = Get-Content $wordlistPath
    foreach ($subdomain in $subdomains) {
        $fullDomain = "$subdomain.$domain"  # Construit le nom complet du sous-domaine
        try {
            # Tente de résoudre les enregistrements A pour le sous-domaine
            $dnsRecord = Resolve-DnsName -Name $fullDomain -Type A -ErrorAction Stop
            if ($dnsRecord) {
                # Si un enregistrement est trouvé, l'affiche avec l'adresse IP correspondante
                Write-Host "Trouver: $fullDomain - $($dnsRecord.IPAddress)"
            }
        } catch {
            # En cas d'erreur (par exemple, aucun enregistrement trouvé), continue sans afficher de message
        }
    }
}

# Vérifie si le paramètre 'domain' est fourni, sinon affiche l'utilisation du script
if (-Not $domain) {
    Write-Host "Usage: .\fluffy-DNSenum.ps1 -domain example.com [-wordlistPath subdomains.txt]"
    exit
}

# Appelle les fonctions pour énumérer les enregistrements DNS et effectuer le brute force des sous-domaines
Enumerate-Dns -domain $domain
Bruteforce-Subdomains -domain $domain -wordlistPath $wordlistPath