sudo apt-get install x11vnc -y
echo "1"
sudo sh -c 'cat <<EOT > /lib/systemd/system/x11vnc.service
[Unit]
Description=x11vnc service
After=display-manager.service network.target syslog.target

[Service]
Type=simple
ExecStart=/usr/bin/x11vnc -forever -display :0 -auth guess -passwd jmes!20191107
ExecStop=/usr/bin/killall x11vnc
Restart=on-failure

[Install]
WantedBy=multi-user.target'

systemctl daemon-reload
systemctl enable x11vnc.service
systemctl start x11vnc.service
sudo sh -c 'cat <<EOT > /etc/lightdm/lightdm.conf
[SeatDefaults]
autologin-user=pi
autologin-user-timeout=0
user-session=ubuntu
greeter-session=unity-greeter'

sudo sh -c 'cat <<EOT > /etc/lightdm/lightdm.conf.d/50-myconfig.conf
[SeatDefaults]
autologin-user=pi'

echo "2"
sudo mkdir /home/pi/.config/autostart
echo "3"
sudo sh -c 'cat <<EOT > /home/pi/.config/autostart/kiosk.desktop
[Desktop Entry]
Type=Application
Name=Kiosk
Exec=/home/pi/kiosk.sh
X-GNOME-Autostart-enabled=true'

chmod +x kiosk.sh

sudo rm /etc/apt/apt.conf.d/20auto-uprades
sudo sh -c 'cat <<EOT > /etc/apt/apt.conf.d/20auto-uprades
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::AutocleanInterval "0";
APT::Periodic::Unattended-Upgrade "0";'

sudo reboot
