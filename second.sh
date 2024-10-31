echo 'jmes!20191107' | sudo -S apt-get install x11vnc -y
echo "1"
echo 'jmes!20191107' | sudo -S sh -c 'cat <<EOT > /lib/systemd/system/x11vnc.service
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

echo 'jmes!20191107' | sudo -S systemctl daemon-reload
echo 'jmes!20191107' | sudo -S systemctl enable x11vnc.service
echo 'jmes!20191107' | sudo -S systemctl start x11vnc.service

echo 'jmes!20191107' | sudo -S sh -c 'cat <<EOT > /etc/lightdm/lightdm.conf
[SeatDefaults]
autologin-user=pi
autologin-user-timeout=0
user-session=ubuntu
greeter-session=unity-greeter'

echo 'jmes!20191107' | sudo -S sh -c 'cat <<EOT > /etc/lightdm/lightdm.conf.d/50-myconfig.conf
[SeatDefaults]
autologin-user=pi'

echo "2"
echo 'jmes!20191107' | sudo -S mkdir -p /home/pi/.config/autostart
echo "3"
echo 'jmes!20191107' | sudo -S sh -c 'cat <<EOT > /home/pi/.config/autostart/kiosk.desktop
[Desktop Entry]
Type=Application
Name=Kiosk
Exec=/home/pi/kiosk.sh
X-GNOME-Autostart-enabled=true'

chmod +x kiosk.sh

echo 'jmes!20191107' | sudo -S rm /etc/apt/apt.conf.d/20auto-uprades
echo 'jmes!20191107' | sudo -S sh -c 'cat <<EOT > /etc/apt/apt.conf.d/20auto-uprades
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::AutocleanInterval "0";
APT::Periodic::Unattended-Upgrade "0";'
echo 'jmes!20191107' | sudo -S apt install ubuntu-advantage-tools -y
echo 'jmes!20191107' | sudo -S pro config set apt_news=false
echo 'jmes!20191107' | sudo -S apt install python3-pip -y
pip3 install websockets
echo 'jmes!20191107' | sudo -S apt install sshpass -y
echo 'jmes!20191107' | sudo -S apt install scrot -y

# crontab 설정 (자동으로 nano 선택 및 작업 수행)
export VISUAL=nano
export EDITOR=nano
(crontab -l 2>/dev/null; echo "*/1 * * * * python3 /home/pi/monitor.py") | crontab -

echo 'jmes!20191107' | sudo -S reboot

