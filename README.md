# Test back-end RUBY

## Stack
- Un projet Rails (Rails >= 7, Ruby >= 3), avec une BDD en Postgres.
- Tu peux utiliser les librairies supplémentaires de ton choix si tu en sens l'utilité.

## Specs
- Un endpoint d’API REST en JSON pour s'inscrire
- L'utilisateur envoie un pseudo de 3 lettres exactement (A à Z, tout en majuscule. Pas de chiffre), ni plus, ni moins.
- Si le pseudo :
  - est libre, on l'enregistre, et on répond à l'utilisateur avec le pseudo qu'il vient d’enregistrer.
  - n'est pas libre, on en trouve un libre, avec les mêmes règles que précédemment (3 lettres exactement, A à Z, tout en majuscule,
pas de chiffre), on l'enregistre, et on lui répond ce pseudo en question. Le pseudo libre que l'app choisit pour l'utilisateur dans ce cas
n'a pas besoin de ressembler de près ou de loin au pseudo choisi par l'utilisateur.

## Informations importantes:

* Ruby version : 3.2.2
* Rails version : 7.0.6

* Dépendances du système : PostgreSQL, Rspec, FactoryBot.

* Configuration : Clonez le dépôt sur votre machine. Naviguez vers le répertoire du projet. Exécutez bundle install pour installer les dépendances des gemmes.

* Création et Initialisation de la base de données : Pour configurer la base de données, exécutez "rails db:create db:migrate"

* Comment exécuter la suite de tests : Utilisez la commande "rspec" pour exécuter la suite de tests.

* Utilisation via l'interface de ligne de commande : Lancez l'application avec "sudo ./bin/dev" puis éxecutez la commande "curl -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{"user": {"pseudo": "USB"}}' http://localhost:3000/api/v1/users".

* Utilisation via l'interface : Lancez l'application avec "sudo ./bin/dev". L'application a également une interface utilisateur pour interagir avec elle. Accédez simplement à http://localhost:3000/, suivez les instructions à l'écran et utilisez le formulaire pour interagir avec l'application.
