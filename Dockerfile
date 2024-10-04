FROM jenkins/jenkins:2.452.2-jdk17

USER root

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y lsb-release

# Ajouter la clé GPG pour Docker et configurer le dépôt
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Installer Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

# Nettoyer les fichiers inutiles
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Ajouter l'utilisateur Jenkins au groupe docker
RUN groupadd -f docker && usermod -aG docker jenkins

# Installer Sudo
RUN apt-get update && apt-get install -y sudo

# Revenir à l'utilisateur Jenkins
USER jenkins

# Installer les plugins Jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
