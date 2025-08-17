# Observations personnelles
J'ai choisi d'afficher les valeurs de production d'énergie à l'aide de graphes. J'ai pour cela utilisé la gem [chartkick](https://github.com/ankane/chartkick) couplée à [groupdate](https://github.com/ankane/groupdate).

J'ai conscience que le graphe de production horaire affiche les valeurs avec un décalage. Les onduleurs commencent à produire de l'énergie le 10 Juillet 2025 à 6h du matin d'après le CSV, et cela apparaît à 8h du matin sur le navigateur. C'est dû au fait que mon ordinateur (et donc mon navigateur) est configuré à l'heure de Paris, à UTC+2 (en prenant en compte l'heure d'été). Par défaut j'ai considéré qu'on importait les données au fuseau horaire UTC+0, d'où le décalage. Une amélioration possible serait de permettre à l'utilisateur d'indiquer le fuseau horaire dans lequel les données ont été enregistrées, ou bien si cette valeur est toujours la même, de la prendre en compte avec un offset lors de l'import des données.

J'ai fait le choix de distinguer le modèle de données en un modèle `Inverter` ayant de multiples enfants `InverterProduction`. J'avais initialement travaillé avec un modèle unique `InverterProduction` appelé anciennement `PowerInverterProduction`. Le principal avantage d'avoir deux modèles, est de pouvoir créer des méthodes afin de récupérer la production horaire/journalière d'un ou plusieurs onduleurs. Cela aurait été possible en ayant que le modèle `InverterProduction`, mais cela nécessitait de passer en argument l'identifiant d'un onduleur.

Enfin, j'ai tenté d'écrire de nombreux tests qui m'ont été très utiles. Je pense qu'il est possible d'étendre la couverture de tests, notamment au niveau des données renvoyées dans `index`.

# Sujet

Une [centrale solaire photovoltaïque](https://fr.wikipedia.org/wiki/Centrale_solaire_photovolta%C3%AFque) dispose d'un appareil appelé [datalogger](https://en.wikipedia.org/wiki/Data_logger) qui nous transmet chaque jour des données de production d'énergie.

Cette installation est composée de 2 [onduleurs](https://fr.wikipedia.org/wiki/Onduleur).

Vous devrez construire une application permettant à un·e utilisateur·ice de :

- charger des données de production au format csv depuis une interface web
- disposer de ces données brutes ainsi que des données consolidées dans la base de données
- les consulter depuis une interface web

# Spécifications techniques

Il vous faudra réaliser une interface web simple (pas de mise en forme CSS demandée) qui permet de :
- envoyer un fichier CSV à charger au format CSV uniquement. Elles contiennent la production horaire de chaque onduleur. *(cf fichiers .csv dans ce repository)*
- voir la production totale d'une journée (au choix de l'utilisateur·ice) pour l'ensemble du système avec le total et la production par heure

Dans la base de données on devra pouvoir disposer :
- des données horaires de chaque onduleur
- des données consolidées (somme des énergies) sur la journée pour l'ensemble du système

Pour ce faire, nous mettons à votre disposition un starter d'application `RubyOnRails` + `SQLite` mais, il vous est possible d'utiliser une ou des technologie(s) équivalente(s) si vous n'êtes vraiment pas à l'aise avec `RubyOnRails` (ex: `Django`, `Symfony`, `Laravel`, etc.).

# Nous observerons

- Les modèles créés et leurs relations
- L'algorithme d'import
- La qualité et l'organisation du code en général

Évidemment, nous adapterons nos observations à votre expérience du langage.

**Merci de mettre le code à disposition sur un dépôt git et de nous transmettre les moyens d'y accéder.**
