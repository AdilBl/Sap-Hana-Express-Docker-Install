#!/bin/bash


# Fonction pour supprimer les conteneurs et les images Docker
cleanup_docker() {
    echo "Suppression des conteneurs Docker créés par ce script..."
    sudo docker rm -f hxecontxsa >/dev/null 2>&1

    echo "Suppression des images Docker clonées par ce script..."
    sudo docker rmi saplabs/hanaexpressxsa:2.00.061.00.20220519.1 >/dev/null 2>&1
}

lighcleanup_docker() {
    echo "Suppression des conteneurs Docker créés par ce script..."
    sudo docker rm -f hxecontxsa >/dev/null 2>&1
}

# Vérification des options passées en paramètre
if [ $# -eq 1 ] && [ "$1" == "-D" ]; then
    cleanup_docker
    exit 0
fi

if [ $# -eq 1 ] && [ "$1" == "-d" ]; then
    lighcleanup_docker
    exit 0
fi

if [ $# -eq 1 ] && [ "$1" == "-r" ]; then
    sudo docker exec -it hxecontxsa bash
    exit 0
fi

if [ "$1" != "-d" ] && [ "$1" != "-p" ] && [ "$1" != "-D" ] && [ "$1" != "-r" ]; then
    echo "./install.sh -p <URL> to start sap hana OR ./install.sh -d to delete sap hana express"
    exit 1
fi

if [ "$1" == "-p" ] && [ $# != 2 ]; then
    echo "./install.sh -p <URL>"
    exit 1
fi

# Récupération de l'URL à partir du deuxième argument
url=$2

# Exécution de la commande 'sudo docker pull saplabs/hanaexpress/'

if [ "$1" == "-p" ]; then

    echo "fs.file-max=20000000" | sudo tee -a /etc/sysctl.conf
    echo "fs.aio-max-nr=262144" | sudo tee -a /etc/sysctl.conf
    echo "vm.memory_failure_early_kill=1" | sudo tee -a /etc/sysctl.conf
    echo "vm.max_map_count=135217728" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv4.ip_local_port_range=40000 60999" | sudo tee -a /etc/sysctl.conf

    sh -c 'echo 127.0.0.1   hxehost >> /etc/hosts'

    sudo docker login

    sudo docker pull saplabs/hanaexpressxsa:2.00.061.00.20220519.1

    if id "hxehost" >/dev/null 2>&1; then
        echo "L'utilisateur hxehost existe déjà."
    else
        # Exécution de la commande 'sudo useradd -m -G sudo hxehost'
        sudo useradd -m -G sudo hxehost
    fi

    sudo mkdir -p /data/sap

    sudo chown 12000:79 /data/sap

    # Execution du docker.
    sudo docker run -p 39013:39013 -p 39015:39015 -p 39041-39045:39041-39045 -p 1128-1129:1128-1129 -p 59013-59014:59013-59014 -p 39030-39033:39030-39033 -p 51000-51060:51000-51060 -p 53075:53075 -h hxehost -v /data/sap:/hana/mounts --ulimit nofile=1048576:1048576 --sysctl kernel.shmmax=1073741824 --sysctl net.ipv4.ip_local_port_range='60000 65535' --sysctl kernel.shmmni=4096 --sysctl kernel.shmall=8388608 --name hxecontxsa saplabs/hanaexpressxsa:2.00.061.00.20220519.1 --agree-to-sap-license --passwords-url $url

fi
