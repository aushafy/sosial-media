# This is a script to setup a sosial media, based on python
# This script must be automated to detect what's your OS based on, but limited only for Linux platform

import distro, os, yaml

def load_configuration():
    configuration_file=os.getcwd()+"/config.yaml"
    with open(configuration_file) as file:
        data=yaml.load(file, Loader=yaml.FullLoader)
        return data

def distro_check(distro_name):
    if str(distro_name) != "Ubuntu":
        print("This script only support for ubuntu distro, feel free to contribute if you use another distros")
        exit(1)
    else:
        os.system("clear")
        print("This machine is running on a {} distro".format(distro.name()))

def setup_sosialmedia(GIT_URL, DB_HOST, DB_USER, DB_PASS, DB_NAME):
    print("Installation in progress...")
    os.system("sudo apt-get update -y && sudo apt-get install apache2 git mariadb-client php php-mysql -y")
    os.system("sudo git clone {GIT_URL}")
    os.system("sudo mv sosial-media/* /var/www/html")
    os.system("sudo sed -i 's/localhost/{DB_HOST}/' /var/www/html/config.php")
    os.system("sudo rm /var/www/html/index.html")
    os.system("sudo mysql -h {DB_HOST} -u {DB_USER} -p{DB_PASS} {DB_NAME} < /var/www/html/dump.sql")
    os.system("sudo systemctl enable apache2 && sudo systemctl restart apache2")

# this is main function    
if __name__=="__main__":    
    # first run, this script would check your OS Distro
    distro_check(distro.name())
    
    # store data from load configuration to a variable
    GIT_URL=load_configuration()['git_url']
    DB_HOST=load_configuration()['db_host']
    DB_USER=load_configuration()['db_user']
    DB_PASS=load_configuration()['db_pass']
    DB_NAME=load_configuration()['db_name']
    
    # initial setup sosial media
    setup_sosialmedia(GIT_URL, DB_HOST, DB_USER, DB_PASS, DB_NAME)