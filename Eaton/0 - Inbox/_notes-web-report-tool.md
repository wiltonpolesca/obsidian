# Web Report Tool

Repo: https://github.com/etn-utilities/cyme-di-web-report-tool

## Email 2026-08-11

Bonjour @Pelletier, Sylvain,

En regardant la technologie actuellement utilisée, j'ai l'impression que ce projet a été développé il y a un certain temps. Il s'appuie sur des outils et des versions de bibliothèques qui sont maintenant désuets ou qui ne sont plus maintenus.

Si ça présente un intérêt pour Eaton, ce projet pourrait être un très bon point de départ pour entreprendre une modernisation du Gateway.

On pourrait préparer une proposition basée sur la version la plus récente de .NET, avec une architecture _self-hosted_ et une interface Web développée en ReactJS ou Angular. Cela permettrait d'éliminer la dépendance à IIS et offrirait la possibilité de déployer l'application soit comme service Windows, soit dans des conteneurs Docker. Ces deux approches ne sont pas mutuellement exclusives et pourraient être utilisées selon les besoins.

À mon avis, un bon point de départ serait un projet de modernisation ciblé sur cette fonctionnalité de consultation des rapports. Par contre, l'architecture mise en place pourrait facilement servir de base à une modernisation progressive de l'ensemble du Gateway.

Cette initiative apporterait plusieurs avantages, notamment :

- L'utilisation des fonctionnalités les plus récentes de .NET et de C# ;
- Une amélioration importante de l'expérience utilisateur grâce à une interface Web moderne et conviviale ;
- Une maintenance plus simple et une meilleure évolutivité ;
- Une réduction des risques liés à l'utilisation de technologies en fin de vie ;
- Une plateforme mieux préparée pour les besoins futurs.

De plus, cette nouvelle architecture ouvrirait la porte à plusieurs fonctionnalités intéressantes, par exemple :

1. La planification et l'exécution automatisée de tâches directement gérées par le Gateway ;
2. L'envoi de notifications par courriel, systèmes de messagerie ou autres canaux ;
3. La mise en place de mécanismes Pub/Sub permettant, par exemple, d'écouter des sources de données temporelles (comme PI System) et de prendre des décisions en temps réel.

Bref, cette modernisation permettrait non seulement de régler les limitations technologiques actuelles, mais aussi de faire évoluer le Gateway vers une plateforme plus flexible, plus moderne et prête à supporter les besoins futurs de l'entreprise.

Si cette avenue vous semble intéressante, ce serait un plaisir de collaborer à la conception de la solution et à la réalisation d'une preuve de concept (PoC) que nous pourrions vous présenter afin d'en démontrer la valeur et le potentiel.

  

Wilton