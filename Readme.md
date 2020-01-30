# Smartphone Test Farm

# Requirements
  - Ubuntu 19.10
  - Docker
  - Docker Compose
  - OpenSTF 3.4.0


### 1. Install Docker:

```sh
$ sudo apt install docker.io
```

### 2. Install Docker-Compose:

```sh
$ sudo apt install docker-compose
```

### 3. Set ADB Service

```sh
$ sudo apt -y install adb
```

Open a new terminal in the path **/etc/systemd/system/**

```sh
$ sudo -s
$ cat > adbd.service
```

Add the following lines and press **Ctrl + D** to save the file

```
[Unit]
Description=Android Debug Bridge daemon
After=network.target

[Service]
Restart=always
RestartSec=2s
Type=forking
User=root
ExecStartPre=/usr/bin/adb kill-server
ExecStart=/usr/bin/adb start-server
ExecStop=/usr/bin/adb kill-server

[Install]
WantedBy=multi-user.target
```

Now, enable and start the **adbd** service

```sh
$ systemctl enable adbd.service
$ systemctl start adbd.service
```

### 4. Clone and prepare STF repository:

```sh
$ git clone https://github.com/spectrumwgs/stf-poc
$ cd stf-poc
$ mv env.txt .env
```

### 5. Start the farm:

Open a new terminal in the directory where the STF repository was saved

```sh
$ sudo docker-compose up --build
```

## References
  - [Ubuntu download link][Dwld]
  - [Original OpenSTF website][OStf]
  - [Docker-compose STF repository][Repo]
  - [Docker-compose STF configuration post][Post]
  - [Alternative docker-compose STF configuration post][PAlt]
  - [RethinkDB installation documentation][ReDB]

[Dwld]: <http://releases.ubuntu.com/19.10/ubuntu-19.10-desktop-amd64.iso?_ga=2.208302160.351755930.1579897946-533501981.1579552170>
[OStf]: <https://openstf.io/>
[Repo]: <https://github.com/nikosch86/stf-poc>
[Post]: <https://medium.com/@nikosch86/getting-started-with-automated-in-house-testing-on-android-smartphones-using-stf-dafecee4a8ee>
[PAlt]: <https://testerhome.com/topics/17233>
[ReDB]: <https://rethinkdb.com/docs/install/ubuntu>
