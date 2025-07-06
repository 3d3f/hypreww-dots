#!/bin/sh

# Funzione per verificare la presenza dei comandi richiesti
check_dependencies() {
  for cmd in git pacman flatpak micro; do
    if ! command -v "$cmd" > /dev/null 2>&1; then
      echo "Error: package '$cmd' not found."
      exit 1
    fi
  done
}

# Funzione per copiare la configurazione
copy_config() {
  local src="$1"
  local dest="$2"
  if [ -e "$src" ]; then  # Verifica se il file o la directory esistono
    cp -r "$src" "$dest"
  else
    echo "Warning: $src doesn't exist."
  fi
}

# Funzione per controllare se ~/.dotfiles esiste, e se non esiste, crearla con un messaggio
check_and_create_dotfiles() {
  local dir="$HOME/.dotfiles"
  
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"  # Crea la directory se non esiste
    echo "~/.dotfiles directory created."
  fi
}

# Funzione per mostrare il banner
show_banner() {
  echo "██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗"
  echo "██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝"
  echo "██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗"
  echo "██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║"
  echo "██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║"
  echo "╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝"
  echo "███████╗ ██████╗██████╗ ██╗██████╗ ████████╗                 "
  echo "██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝                 "
  echo "███████╗██║     ██████╔╝██║██████╔╝   ██║                    "
  echo "╚════██║██║     ██╔══██╗██║██╔═══╝    ██║                    "
  echo "███████║╚██████╗██║  ██║██║██║        ██║                    "
  echo "╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝                    "
  echo
}

# Pulizia schermo e banner
clear
show_banner

# Menu
# echo "Welcome $USER, what would you like to do today?"
echo
echo "a) Update dotfiles in ~/.dotfiles"
echo "b) Add, push and commit dotfiles"
echo "c) Initialize git in ~/.dotfiles"
echo "d) Setup git"
echo "e) Edit this script"
echo "q) Exit"
echo

read answer

# Verifica dipendenze
check_dependencies
# Verifica directory
check_and_create_dotfiles

case $answer in

a)
   clear && show_banner
   echo "Updating dotfiles in in ~/.dotfiles..."

   # Rimuovi tutti i file e le cartelle dentro ~/.dotfiles/ tranne .git
   find "$HOME/.dotfiles" -mindepth 1 -not -path "$HOME/.dotfiles/.git*" -exec rm -rf {} +

   # Backup pacchetti
   pacman -Qeq > ~/.dotfiles/pacman_Qeq_pkgs

   # Backup flatpak
   flatpak list --app --columns=origin --columns=application | awk '{print "flatpak install " $1,$2 " -y"}' > ~/.dotfiles/flatpaks.sh

   # Crea le directory necessarie
   mkdir -p ~/.dotfiles/usr/share/sddm/themes/
   mkdir -p ~/.dotfiles/.config/gtk-3.0/
   mkdir -p ~/.dotfiles/.config/kew/
   mkdir -p ~/.dotfiles/Pictures/
   mkdir -p ~/.dotfiles/.jd/
   mkdir -p ~/.dotfiles/.jd/themes/
   mkdir -p ~/.dotfiles/.local/share/applications/

   # Nautilus bookmarks
   copy_config ~/.config/gtk-3.0/bookmarks ~/.dotfiles/.config/gtk-3.0/

   # Zsh
   copy_config ~/.zshrc ~/.dotfiles/
   copy_config ~/.zsh_history ~/.dotfiles/

   # Bash
   copy_config ~/.bashrc ~/.dotfiles/
   copy_config ~/.bash_history ~/.dotfiles/

   # Hypr
   copy_config ~/.config/hypr ~/.dotfiles/.config/

   # Kitty
   copy_config ~/.config/kitty ~/.dotfiles/.config/

   # JD
   copy_config ~/.jd/cfg ~/.dotfiles/.jd/

   # Yazi
   copy_config ~/.config/yazi ~/.dotfiles/.config/

   # Rofi
   copy_config ~/.config/rofi ~/.dotfiles/.config/

   # Cava
   copy_config ~/.config/cava ~/.dotfiles/.config/

   # Btop
   copy_config ~/.config/btop ~/.dotfiles/.config/

   # Kvantum
   copy_config ~/.config/Kvantum ~/.dotfiles/.config/ 

   # Mpv
   copy_config ~/.config/mpv ~/.dotfiles/.config/

   # Nwg-dock
   copy_config ~/.config/nwg-dock-hyprland ~/.dotfiles/.config/

   # Starship
   copy_config ~/.config/starship.toml ~/.dotfiles/.config/

   # local share applications
   copy_config ~/.local/share/applications ~/.dotfiles/.local/share/

   # Icone e Wallpapers
   copy_config ~/Pictures/icons ~/.dotfiles/Pictures/
   copy_config ~/Pictures/Wallpapers ~/.dotfiles/Pictures/

   # Tema SDDM
   copy_config /usr/share/sddm/themes/TerminalStyleLogin ~/.dotfiles/usr/share/sddm/themes/

   # Default app settings
   copy_config ~/.config/mimeapps.list ~/.dotfiles/.config/

   # qt5ct e qt6ct
   copy_config ~/.config/qt5ct ~/.dotfiles/.config/
   copy_config ~/.config/qt6ct ~/.dotfiles/.config/

   # eww
   copy_config ~/.config/eww ~/.dotfiles/.config/

   # fastfetch
   copy_config ~/.config/fastfetch ~/.dotfiles/.config/

   # kew
   copy_config ~/.config/kew/kewrc ~/.dotfiles/.config/kew/

   # miscellaneus
   copy_config ~/Documents/tosavetogit ~/.dotfiles/
   

   # Check if the operation was successful
   if [ $? -eq 0 ]; then
     echo "Operation completed successfully!"
   else
     echo "An error occurred during the operation."
   fi

   echo "Press any key to return to the menu..."
   read -n 1 -s  # Wait for user input without showing it
   tput reset
   exec sh "$0" "$@"
   ;;

b)
   clear && show_banner
   echo "Uploading dotfiles..."

   # Github
   mkdir -p ~/.dotfiles
   cd ~/.dotfiles 
   git add --all
   git commit -m "dotfiles"
   git push origin main

   # Check if the operation was successful
   if [ $? -eq 0 ]; then
     echo "Operation completed successfully!"
   else
     echo "An error occurred during the operation."
   fi

   echo "Press any key to return to the menu..."
   read -n 1 -s  # Wait for user input without showing it
   tput reset
   exec sh "$0" "$@"
   ;;

c)
   clear && show_banner

   # Rimuovi tutti i file e le cartelle dentro ~/.dotfiles/ tranne .git
   find "$HOME/.dotfiles" -mindepth 1 -not -path "$HOME/.dotfiles/.git*" -exec rm -rf {} +

   # Local folder path
   DOTFILES_DIR="$HOME/.dotfiles"

   # Remote repository URL
   REPO_URL="https://github.com/3d3f/.dotfiles.git"

   # Branch name
   BRANCH="main"

   # Check if the folder exists and is a Git repository
   if [ -d "$DOTFILES_DIR" ]; then
      cd "$DOTFILES_DIR" || exit
      if [ ! -d ".git" ]; then
         echo "The folder is not a Git repository. Initializing..."
         git init
         git remote add origin "$REPO_URL"
      fi
      echo "Repository found. Performing git pull..."
      git pull origin "$BRANCH"
   else
      # If the folder doesn't exist, clone the repository
      echo "Repository not found. Cloning the repository..."
      git clone "$REPO_URL" "$DOTFILES_DIR"
      cd "$DOTFILES_DIR" || exit
   fi

   # Check if the operation was successful
   if [ $? -eq 0 ]; then
      echo "Operation completed successfully!"
   else
      echo "An error occurred during the operation."
   fi

   echo "Press any key to return to the menu..."
   read -n 1 -s  # Wait for the user input without displaying it
   tput reset
   exec sh "$0" "$@"  # Re-run the script
   ;;

d)
   clear && show_banner
   # Configurazione iniziale di git
   echo "Configuring git..."

   # Impostare il nome e l'email globali
   git config --global user.name "3d3f"
   git config --global user.email "dbfside@gmail.com"
   git config --global init.defaultBranch main

   # Verifica della configurazione
   echo "Setup complete:"
   git config --global --list

   # Check if the operation was successful
   if [ $? -eq 0 ]; then
     echo "Operation completed successfully!"
   else
     echo "An error occurred during the operation."
   fi

   echo "Press any key to return to the menu..."
   read -n 1 -s  # Wait for user input without showing it
   tput reset
   exec sh "$0" "$@"
   ;;

e)
   micro ~/.config/hypr/scripts/dotfilesbackup.sh && tput reset && exec sh "$0" "$@"
   ;;

q)
   tput reset && echo "Goodbye!"
   ;;

*)
   echo "Non è una delle opzioni disponibili" && sleep 2 && tput reset && exec sh "$0" "$@"
   ;;
esac
