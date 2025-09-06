# Fix tachpad
Проблема с тем, что на ThinkPad T470p после выхода из сна перестают работать физические кнопки тачпада (TrackPad, но не TrackPoint), довольно типична — это баг в драйверах psmouse/libinput и power management. 
Он наблюдается и в Ubuntu, и в openSUSE, и связан с тем, что устройство не инициализируется корректно после suspend/resume.

1 - Create service.
```bash
sudo nano /etc/systemd/system/psmouse-reset.service
```

```ini
[Unit]
Description=Reload psmouse module on resume
After=suspend.target

[Service]
Type=oneshot
ExecStart=/sbin/modprobe -r psmouse
ExecStartPost=/sbin/modprobe psmouse

[Install]
WantedBy=suspend.target
```
2 - Enable service.
```bash
sudo systemctl enable psmouse-reset.service
```
