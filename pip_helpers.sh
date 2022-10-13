# welcome to pip_helpers
# Author: Suresh Pandiyan
# email: suresh.pandiyan1@outlook.com



pip_install_or_not() {
pip --version > checker.txt

awk  '{if (substr($0,1,5) == "pip 0") print "pip => installed";  
      else if  (substr($0,1,5) == "pip 3") print "pip => installed";
      else if  (substr($0,1,5) == "pip 1") print "pip => installed";
      else if  (substr($0,1,5) == "pip 2") print "pip => installed"; 
      else if  (substr($0,1,5) == "pip 0") print "pip => installed";
      else print "pip => not installed"}' checker.txt

rm checker.txt
}


print_tht() {
read -p "enter your name" name
read -p "enter your package name " packagename
read -p "enter your version " versions
read -p "enter your license " license
read -p "enter your description " description
read -p "enter your author name" authorname
read -p "enter your author email" authoremail
read -p "enter your url" url
read -p "enter your downloadable url" downloadurl
read -p "enter your keywords" keywords
read -p "enter the install requires" installs

echo "from distutils.core import setup"
echo " "
echo " " 
echo " "
echo "setup("
echo "name = [\"$name\"],"
echo "packages = [\"$packagename\"],"
echo "version = \"$versions\","
echo "license = \"$license\","
echo "description = \"$description\","
echo "author = \"$authorname\","
echo "author_email = \"$authoremail\","
echo "url = \"$url\",";
echo "download_url = \"$downloadurl\",";
echo "keywords = $keywords,";
echo "install_requires = $installs,";
echo ")"

echo "# successfully created from pypi_bashy"
}

upload_package() {
echo "please enter below information of pypi login details"
read -p "enter your username: " username
read -s -p "enter your password: " password
python3 -m twine upload -u $username -p $password --repository-url https://test.pypi.org/legacy/ dist/*
}

cpy_virtualenv() {
# check for venv exists or not
thatpath=venv/
for myvenv in $thatpath
do
if [ -d "$myvenv" ];
then
echo "please wait for few mins...."
tar -cf backup_pip_packages.tgz venv/Lib/site-packages/*
echo "succesfully backup your packages in backup_pip_packages.tgz"
else
echo "please try to install virutal environment for your project"
echo "venv is not exists!"
fi
done
}

ipkg() {
pip freeze > requirements.txt
echo "<h1 style=\"display: grid;grid-column: 1;text-align: center;\">Pip Installed Packages</h1>"
echo "<li></li>"
echo "<li></li>"
count=-1
while true 
read line how
do
echo "<body style=\"display: grid;grid-template-columns: 30% 30% 30%;padding: 19px;justify-content: center;list-style: none;gap: 15px;\">"
if [ $line != 'Package' ]; then 
echo "<li>"
(( count ++ ))
echo $line $how
echo "</li>"
fi
done < requirements.txt
minus=1
total=($count - $minus)

echo "<h3 style=\"display: grid;grid-column: 1;text-align: left;font-size: 40px;width: 500px;color: green;\">$total package were installed</h3>"

}

upgrade_your_pip() {
python3 -m pip install --upgrade pip
}

while true
do
clear
echo "welcome to pip_helpers"
echo "copyright @ Suresh P | All Rights Reserved"
echo ""
echo "1. check pip installed or not"
echo "2. create pypi setup.py"
echo "3. create requirements.txt and report about packages"
echo "4. upload your package to pypi"
echo "5. upgrade pip"
echo "6. backup your pip packages"
echo "7. quit"
read -sn1
read -p "choose the option: " options
case $options in
1) pip_install_or_not;;
2) print_tht > setup.py;;
3) ipkg > pip_package_report.html | echo "succesfully created - take a look at requirements.txt and pip_package_report.html !!";;
4) upload_package;;
5) upgrade_your_pip;;
6) cpy_virtualenv;;
7) exit 0;;
esac
read -n1 -p "Press any key to continue"
done

