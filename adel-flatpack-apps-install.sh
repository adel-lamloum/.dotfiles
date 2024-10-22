#!bin/bash


echo "##########################################"
echo "####### INSTALL SELECTED ADEL'S flatpak APPS #####"
sleep 3
sudo pacman -S --noconfirm --needed flatpak

flatpak install -y flathub io.github.benini.scid
#flatpak install -y flathub com.jetbrains.PyCharm-Community
flatpak install -y Flatseal
#flatpak install -y org.telegram.desktop
flatpak install -y drawio
#flatpak install -y midori
#flatpak install -y com.obsproject.Studio
#flatpak install -y com.github.xournalpp.xournalpp
flatpak install -y bottles
flatpak install -y com.github.arminstraub.krop
#flatpak install -y org.onlyoffice.desktopeditors
#flatpak install -y flathub com.discordapp.Discord
#flatpak install -y flathub it.mijorus.gearlever
#flatpak install -y flathub us.zoom.Zoom
flatpak install -y flathub org.gnome.gitlab.YaLTeR.VideoTrimmer
flatpak install -y flathub dev.geopjr.Calligraphy
flatpak install -y flathub dev.bragefuglseth.Keypunch
flatpak install -y flathub org.gaphor.Gaphor
flatpak install -y flathub io.github.flattool.Warehouse
#flatpak install -y flathub app.drey.Warp
echo "#####################DONE###############################################"
sleep 3


