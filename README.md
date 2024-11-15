# Application de Prise de Notes

## Description

Cette application permet à l'utilisateur de prendre des notes de manière simple et efficace. Elle propose un affichage de notes sous forme de liste et permet à l'utilisateur d'ajouter, supprimer et visualiser les détails d'une note.

L'application utilise des fragments pour gérer les différentes vues en fonction de l'orientation de l'écran (portrait ou paysage), et la gestion du cycle de vie des activités permet de récupérer les notes en cas de rotation.

## Fonctionnalités

- **Splash Screen** : L'application commence par un écran d'accueil avec animation.
- **Liste des Notes** : L'utilisateur peut ajouter des notes via un bouton en bas de l'écran. Les notes sont affichées dans une liste recyclée.
- **Suppression des Notes** : L'utilisateur peut supprimer une note en maintenant son doigt dessus (long click) et en confirmant l'action.
- **Vue Détails de la Note** : En mode portrait, l'utilisateur peut voir les détails complets d'une note dans une nouvelle activité. En mode paysage, les détails s'affichent dans un fragment à côté de la liste.
- **Synthèse Vocale** : L'utilisateur peut écouter une synthèse vocale du texte d'une note. La lecture s'arrête si l'utilisateur change d'activité ou quitte l'application.
- **Gestion de la Rotation** : Lors d'une rotation de l'écran, les notes sont récupérées sans perdre les données.

## Prérequis

- Android API 21 (Lollipop) ou version supérieure.
- Permissions pour accéder au stockage et utiliser la synthèse vocale.

## Cycle de Vie et Rotation

L'application gère correctement la rotation de l'écran. Lorsqu'une rotation se produit, les notes sont récupérées sans que l'utilisateur perde les données ou l'état de l'application.

## Conclusion

Cette application permet à l'utilisateur de prendre des notes et de les gérer facilement grâce à une interface simple. Les fonctionnalités de synthèse vocale et de gestion des activités avec fragments rendent l'expérience utilisateur encore plus fluide et interactive.