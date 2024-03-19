# DNF Commands
 
### Descriere:
- Acest script configurează și creează comenzi pentru gestionarea pachetelor în Fedora utilizând DNF.
- El creează fișierele `update`, `upgrade`, `search`, `install` și `remove` în directorul **~/.bin** și adaugă directorul `~/.bin` la calea de căutare a executabilelor ($PATH) în fișierul **.bashrc**.

### Utilizare:
1. Rulați acest script într-un terminal, folosind comanda: `./dnf_commands.sh`
2. După rularea scriptului, puteți utiliza comenzile create (update, upgrade, search, install, remove) în terminal.
3. Comenzile pot fi rulate direct din terminal fără a specifica calea către directorul `~/.bin`.