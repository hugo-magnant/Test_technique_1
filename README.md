# README

Ce README documente les étapes nécessaires pour mettre en route l'application Cheerz.

#
Informations importantes:
* Ruby version : 3.2.2
* Rails version : 7.0.6

* Dépendances du système : PostgreSQL, Rspec, FactoryBot.

* Configuration : Clonez le dépôt sur votre machine. Naviguez vers le répertoire du projet. Exécutez bundle install pour installer les dépendances des gemmes.

* Création et Initialisation de la base de données : Pour configurer la base de données, exécutez "rails db:create db:migrate"

* Comment exécuter la suite de tests : Utilisez la commande "rspec" pour exécuter la suite de tests.

* Utilisation via l'interface de ligne de commande : Lancez l'application avec "sudo ./bin/dev" puis éxecutez la commande "curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{"user": {"pseudo": "ABC"}}' http://localhost:3000/users".

* Utilisation via l'interface : Lancez l'application avec "sudo ./bin/dev". L'application a également une interface utilisateur pour interagir avec elle. Accédez simplement à http://localhost:3000/, suivez les instructions à l'écran et utilisez le formulaire pour interagir avec l'application.
