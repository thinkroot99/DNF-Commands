#!/bin/bash

##########################################################################################################################
# Script: DNF Commands
# Autor: ThinkRoot
# Versiune: 2.1

# Descriere:
#   Acest script configurează și creează comenzi pentru gestionarea pachetelor în Fedora utilizând DNF.
#   El creează fișierele update, upgrade, search, install și remove în directorul ~/.bin și adaugă directorul ~/.bin la calea de căutare a executabilelor ($PATH) în fișierul .bashrc.

# Utilizare:
# 1. Rulați acest script într-un terminal, folosind comanda: ./dnf_commands.sh
# 2. După rularea scriptului, puteți utiliza comenzile create (update, upgrade, search, install, remove) în terminal.
# 3. Comenzile pot fi rulate direct din terminal fără a specifica calea către directorul ~/.bin.
##########################################################################################################################


# Verificăm dacă directorul ~/.bin există, altfel îl creăm
if [ ! -d "$HOME/.bin" ]; then
    mkdir "$HOME/.bin"
    echo "Directorul ~/.bin a fost creat."
fi

# Funcție pentru crearea și configurarea scripturilor
create_script() {
    local script_name="$1"
    local script_content="$2"
    local script_file="$HOME/.bin/$script_name"

    # Verificăm dacă fișierul de script există deja, altfel îl creăm și adăugăm conținutul
    if [ ! -f "$script_file" ]; then
        # Cream fișierul de script și adăugăm conținutul
        cat <<EOF > "$script_file"
#!/bin/bash

$script_content
EOF

        # Dăm permisiuni de execuție pentru fișierul de script
        chmod +x "$script_file"

        echo "Fișierul \"$script_file\" a fost creat și configurat."
    else
        echo "Fișierul \"$script_file\" există deja. Nu se face nimic."
    fi
}

# Creăm și configurăm fișierele update, upgrade, search, install, remove

create_script "update" "sudo dnf update \"\$@\""
create_script "upgrade" "sudo dnf upgrade \"\$@\""
create_script "search" "dnf search \"\$@\""
create_script "install" "sudo dnf install \"\$@\""
create_script "remove" "sudo dnf remove \"\$@\""

# Adăugăm linia necesară în fișierul .bashrc dacă nu există deja
BASHRC_FILE="$HOME/.bashrc"
LINE_TO_ADD="export PATH=\"\$HOME/.bin:\$PATH\""

if ! grep -qF "$LINE_TO_ADD" "$BASHRC_FILE"; then
    echo "$LINE_TO_ADD" >> "$BASHRC_FILE"
    echo "Linia \"$LINE_TO_ADD\" a fost adăugată în fișierul \"$BASHRC_FILE\"."
else
    echo "Linia \"$LINE_TO_ADD\" există deja în fișierul \"$BASHRC_FILE\". Nu se face nimic."
fi

# Aplicăm modificările în shell-ul curent
source "$BASHRC_FILE"

echo "Configurarea a fost finalizată."
