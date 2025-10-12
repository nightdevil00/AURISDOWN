How to Use the Script
   0. Download the script and make it executable with chmod +x
   1. Navigate to your home directory or where the script is located.
   2. Run the script with the name of the package you want to install.

  For example, to install the package btop:

   1 ./aur-install.sh btop

  The script will then download, build, and install the package. Since package installation requires root privileges,
  you will be prompted to enter your sudo password during the final step.
3. Combined.sh - This script installs a package from the Arch User Repository (AUR). It first checks if the AUR website is accessible. 
If it is, it uses the `yay` AUR helper to install the package. 
If the AUR website is down, it falls back to a manual installation method by cloning the package's git repository from the AUR and building it using `makepkg`.
