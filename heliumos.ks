# network configuration
network --bootproto=dhcp --device=link --activate

# Partioning Setup
clearpart --all --initlabel --disklabel=gpt
reqpart --add-boot
part / --grow --fstype xfs

# -- Disable Kdump --
%addon com_redhat_kdump --disable
%end

# --- Container Image Installation --
ostreecontainer --url quay.io/heliumos/bootc:10

# --- Basic Security ---
firewall --disabled

rootpw --iscrypted locked #Disable direct root password login

# --- Bootloader ---
bootloader --append "rhgb quiet"

%post

rm -f /var/lib/systemd/random-seed

# --- systemd Services ---
systemctl disable kdump.service
systemctl enable gdm.service
systemctl enable flatpak-remotes.service

%end

