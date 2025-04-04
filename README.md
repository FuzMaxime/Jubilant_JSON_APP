# Jubilant_JSON_APP

Une application Flutter multiplateforme conçue pour le challenge 48H à Ynov Nantes.

Team:
- FUZEAU Maxime
- GAUDIN Jeremy
- SABINOTTO NZIGOU Claude
- DOUAUD Camille
- BIGOT Lucas
- OLIVIER Alexandre
- CUZOU Yamao
- POISSON Pissith

## Prérequis

Avant de commencer, assurez-vous que les éléments suivants sont installés sur votre machine :

- **Flutter SDK** (version recommandée : 3.6.0 ou supérieure)
- **Dart SDK**
- **Android Studio**
- Un émulateur ou un appareil physique pour tester l'application.


## Installation et Lancement

### Étape 1 : Cloner le dépôt

Clonez ce dépôt sur votre machine locale :

```
git clone https://github.com/FuzMaxime/Jubilant_JSON_APP.git
cd Jubilant_JSON_APP
```

### Étape 2 : Installer Flutter

Assurez-vous que Flutter est correctement configuré. Pour vérifier, exécutez :

```
flutter doctor
```

Résolvez les éventuels problèmes affichés.

### Étape 3 : Installer les dépendances

Dans le répertoire du projet, installez les dépendances nécessaires :

```
flutter pub get
```

### Étape 4 : Confiuration du `.env`

Dupliquer le fichier `.env.example` et le renommer en `.env`.

Ajouter la `API_URL` et `API_KEY` dans le nouveau fichier `.env`.


### Étape 5 : Lancer l'application

Pour exécuter l'application sur un appareil physique a partir de Android Studio:

- Ce deplacer dans `cd jubilant_json_app`
- Se connecter à l'appareil en mode fillaire (USB)
  - *L'appareil doit autoriser l'USB Debugging dans les paramètres développeurs*
- Selectionner l'appareil physique sur lequel lancer l'application
- Lancer l'application en mode debug

**L'application mettra du temps à se lancer lors de la première tentative** 

---

## Structure du Projet

Voici un aperçu de la structure des fichiers principaux du projet :

```
MonProjetFlutter/
├── lib/
│ ├── main.dart # Point d'entrée principal de l'application.
├── pubspec.yaml # Fichier de configuration des dépendances.
├── android/ # Fichiers spécifiques à Android.
├── ios/ # Fichiers spécifiques à iOS.
├── web/ # Fichiers spécifiques au Web.
└── test/ # Tests unitaires et d'intégration.
```

---

