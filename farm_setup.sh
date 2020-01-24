source /etc/lsb-release && echo "deb https://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -

sudo apt-get update
sudo apt-get install rethinkdb
sudo apt install docker.io
sudo apt install docker-compose

git clone https://github.com/spectrumwgs/stf-poc
cd stf-poc
sudo mv env.txt .env

gnome-terminal -- bash -c "rethinkdb --bind all; bash" &

sudo docker-compose up -d --build

echo -e "\e[32mAll Done!"
