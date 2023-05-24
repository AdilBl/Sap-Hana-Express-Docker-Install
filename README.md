
# Sap Hana, expressXSA Edition Docker installation

A script based on the official sap tutorial [Sap Hana Express Docker](https://linktodocumentation) 

# Prerequisite

## Docker



## Password
You need to setup password for SAP HANA EXPRESS use  the following formats to create the 

```bash
{
"master_password" : "<password>"
}
```

The password must comply with these rules:

At least 8 characters\
At least 1 uppercase letter\
At least 1 lowercase letter\
At least 1 number\
Can contain special characters, but not ` (backtick), $ (dollar sign), \ (backslash), ' (single quote), or " (double quotation marks).\
Cannot contain dictionary words\
Cannot contain simplistic or systemic values, like strings in ascending or descending numerical or alphabetical order

\
There are 2 methods to setup the password


###  Method 1

Create a .json where you setup the password and when executing the ./install.sh pass as a parameter the .json like 

```bash
sudo ./install.sh -p file:///<path to .json>
```

### Method 2

If you have a issue with the first method i advise to use this méthod you need to set up your password in a wesbsite like [jsonserve](https://jsonserve.com/) and get your json url like

```bash
sudo ./install.sh -p <URL>
```


## Install Locally

Clone the project

```bash
  git clone https://github.com/AdilBl/Sap-hanna-expressxsa-docker-installation.git
```

Go to the project directory

```bash
  cd Sap-hanna-expressxsa-docker-installation
```

Install dependencies

```bash
  chmod +x install.sh
```

Start the script

```bash
  sudo ./install.sh -p <URL> OR file:///<path to .json>
```


## Run Locally

```bash
    ./install.sh -r
```

Or

```bash
    docker exec -it hxecontxsa bash
```

## Uninstallation

To desinstall everything you can do

```bash
    ./install.sh -D
```

## Reinstatement

```bash
    ./install.sh -d
```

And restart the project

```bash
    sudo ./install.sh -p <URL> OR file:///<path to .json>
```
