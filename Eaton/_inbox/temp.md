Je pense que la meilleure approche, c’est que le développeur utilise ces scripts pour générer les modifications dont il a besoin et, une fois qu’il a fait tous ses tests (qui peuvent être différents des tests d’intégration), il valide les changements du code et des DLL (qui sont actuellement dans Git).

Ça évite de devoir créer une pull request, lancer le workflow, télécharger les artefacts pour les tests, etc.

En résumé, le développeur n’a qu’à modifier le fichier de configuration (et dans le cas d’une nouvelle fonctionnalité, créer aussi un nouveau script de test), puis exécuter le script : tout le travail répétitif sera automatisé.

Enfin, créez une PR sur Github.