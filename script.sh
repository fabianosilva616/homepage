#! /bin/bash # Padrão
if [ ! -x /etc/init.d/apache2 ]; then 
echo "apache não encontrado. iniciando a Instalação ..." 
sudo apt-get update              
sudo apt-get install apache2 -y  
sudo mkdir -p /var/www/aluno/public_html 
git clone https://github.com/matheusmanvel/site-simples-com-html-e-css.git 
sudo mv site-simples-com-html-e-css/* /var/www/aluno/public_html/ 
sudo rm -rf site-simples-com-html-e-css/

sudo tee /etc/apache2/sites-available/aluno.conf <<-EOF
<VirtualHost *:80>
    ServerAdmin admin@aluno
    ServerName aluno
    ServerAlias www.aluno
    DocumentRoot /var/www/aluno/public_html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo a2ensite aluno.conf  
sudo echo "127.0.0.1 aluno" | sudo tee -a /etc/hosts
sudo /etc/init.d/apache2 restart
