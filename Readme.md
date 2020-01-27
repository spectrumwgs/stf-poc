# STF Setup

The following steps were done and tested on a virtual machine using **VirtualBox** with **Ubuntu 19.10** and **Gnome 3.34**

## Quick Install

To quickly setup everything, you can just open your Ubuntu terminal and run the next command:

```sh
$ sudo curl -s https://raw.githubusercontent.com/spectrumwgs/stf-poc/master/farm_setup.sh | bash -s --
```

If you want to change the **PUBLIC_IP**, **SECRET** or **STATION_NAME** of the farm, you can do so by editing the **.env** file with any text editor, but first, you must shut down docker. You can do so by using the following command:

```sh
$ sudo docker stop $(sudo docker ps -a -q)
```

After doing the appropiate changed to the environment file, you can now rebuild docker and start the farm again with this command (using a terminal that was launched within the cloned git project):

```sh
$ sudo docker-compose up -d --build
```

## Step by Step

### 1. Install Docker:

To install Docker, you must first open the Linux terminal, this can be done by either pressing **Ctrl + Alt + T** (Ubuntu) or by going to the **Show Applications** menu and clicking on the **Terminal** icon. Once the console is open you can write the following command.

```sh
$ sudo apt install docker.io
```

After a short while, Linux should’ve downloaded and installed Docker. To verify that this process was done correctly, you can run the following command:

```sh
$ sudo docker run hello-world
```

If a greeting message from Docker’s development team shows up, that means that docker was successfully installed in your computer and you can proceed to the next step.

### 2. Install Docker-Compose:

You can install Docker-Compose in the same way you previously installed Docker with. First, start by opening the terminal, then, just use the following command:

```sh
$ sudo apt install docker-compose
```

The download and installation process shouldn’t take long. And again, if you feel like verifying the integrity of the installation you can run the next line:

```sh
$ docker-compose
```

A list with all the commands from docker-compose should show up.

### 3. Install RethinkDB:

With the terminal still open, you can install RethinkDB through the next command:

```sh
source /etc/lsb-release && echo "deb https://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install rethinkdb
```

Through this command you add a new source to the list of repositories Linux uses, so the apt command can properly find and download RethinkDB.

### 4. Clone STF repository:

The main project is allocated in a repository in github, in order to deploy it you must first clone it into your local computer. This can be done by running this command:

```sh
$ git clone https://github.com/spectrumwgs/stf-poc
```

A new folder with the project’s content should be created at your Home directory. 

Due to github’s security measures, not all of the files in the repository are copied when using the clone command, this is done as said files may contain sensitive information, so they are omitted in the process. One such file is **.env**, which is required to set the environment variables for the docker build. An easy way to solve this problem is to open any text editor and manually create that file in the project directory. The file should contain the following text:

```
PUBLIC_IP=0.0.0.0
SECRET=change_me
RETHINKDB_PORT_28015_TCP=tcp://rethinkdb:28015
STATION_NAME=farm
```

It is recommended to change the **PUBLIC_IP**, which will handle the connections, and the **SECRET**, which will be used to manage inter-service authentication.

### 5. Start the farm:

Before starting the farm, you need to have the RethinkDB process ready and running, to do this all you have to do is run the following command:

```sh
$ sudo rethinkdb --bind all
```

Now, you can build the image. In order to do that, you have to change your terminal directory to the root of your project, once in there, you can now use the build command for docker-compose. This is done through these commands:

```sh
$ cd stf-poc
$ sudo docker-compose up -d --build
```

If everything up to this point was done correctly, you should be able to access the device farm in your browser through the **PUBLIC_IP** you previously defined.

## References
  - [Ubuntu download link][Dwld]
  - [Original OpenSTF website][OStf]
  - [Docker-compose STF repository][Repo]
  - [Docker-compose STF configuration post][Post]
  - [RethinkDB installation documentation][ReDB]

[Dwld]: <http://releases.ubuntu.com/19.10/ubuntu-19.10-desktop-amd64.iso?_ga=2.208302160.351755930.1579897946-533501981.1579552170>
[OStf]: <https://openstf.io/>
[Repo]: <https://github.com/nikosch86/stf-poc>
[Post]: <https://medium.com/@nikosch86/getting-started-with-automated-in-house-testing-on-android-smartphones-using-stf-dafecee4a8ee>
[ReDB]: <https://rethinkdb.com/docs/install/ubuntu>
