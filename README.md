Essa documentação tem como objetivo a a instalação do apache via Script e subir o site de maneira mais rapida.

Acesse a maquina virtualizada e utilize o comando "sudo nano script.sh" digite sua senha e clique em enter.

No arquivo preencha com as informações.

#! /bin/bash # Padrão
if [ ! -x /etc/init.d/apache2 ]; then # Comando para verificar se o apache2 está instalado, caso não esteja inicia a instalação.
echo "apache não encontrado. iniciando a Instalação ..." # Após executar e indentificado que não estava instalado, inicia a instalação.
sudo apt-get update              # Atualiza os repositórios do sistema.
sudo apt-get install apache2 -y  # Instala o Apache2 automaticamente (-y para confirmar).
sudo mkdir -p /var/www/aluno/public_html # Cria a estrutura de diretórios para o site.
git clone https://github.com/matheusmanvel/site-simples-com-html-e-css.git # Clona o repositório do GitHub.
sudo mv site-simples-com-html-e-css/* /var/www/aluno/public_html/ # Move os arquivos clonados para o diretório do site.
sudo rm -rf site-simples-com-html-e-css/ # Exclui o diretório do repositório clonado.

# Cria o arquivo de configuração do site no Apache:
```bash
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

sudo a2ensite aluno.conf         # Ativa o arquivo de configuração do site.
sudo echo "127.0.0.1 aluno" | sudo tee -a /etc/hosts # Adiciona 'aluno' ao arquivo hosts para resolução local do domínio.
sudo /etc/init.d/apache2 restart # Reinicia o serviço Apache para aplicar todas as configurações feitas.
