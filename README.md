# CTF_Docker
A Kali Linux docker image with all the tools I use in CTF games.

## Download and build
```shell
git clone https://github.com/aJesus37/CTF_Docker
cd CTF_Docker
sudo docker build -t <image_name> .
```

## Running with graphical support
```shell
sudo docker run --device="/dev/dri/card0" \
--volume="/etc/machine-id:/etc/machine-id:ro" \
--volume="/usr/share/X11/xkb:/usr/share/X11/xkb/:ro" \
--env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
--volume="/tmp/.X11-unix/:/tmp/.X11-unix" --net=host -dit \
--name kali --hostname kali kali_latest /bin/bash
```