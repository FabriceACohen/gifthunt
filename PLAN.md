# Plan de Développement - GiftHunt

Ce document détaille les étapes incrémentales pour la construction de l'application GiftHunt. Chaque étape représente une fonctionnalité ou une couche technique distincte et doit être validée par des tests avant de passer à la suivante.

## Checklist Générale

- [x] Étape 0 : Configuration du Projet et Architecture de Base
- [x] Étape 1 : Phase 1 - Écrans et Logique du Questionnaire d'Onboarding
- [x] Étape 2 : Modèles de Données et Service de Repository (Simulation)
- [x] Étape 3 : Phase 2 - Interface du Jeu de Sélection ("L'entonnoir à idées")
- [x] Étape 4 : Logique du Jeu de Sélection avec Riverpod
- [ ] Étape 5 : Configuration et Connexion à Firebase
- [ ] Étape 6 : Intégration de Firestore pour les Produits
- [ ] Étape 7 : Redirection vers le Site Partenaire
- [ ] Étape 8 : Authentification Utilisateur (Optionnelle)
- [ ] Étape 9 : Sauvegarde des "Chasses" pour les Utilisateurs Connectés

---

## Étape 0 : Configuration du Projet et Architecture de Base

**Objectif :** Mettre en place un squelette d'application sain et scalable.

1.  **Ajouter les dépendances :**
    *   `flutter_riverpod`, `riverpod_annotation` pour la gestion d'état.
    *   `firebase_core`, `cloud_firestore`, `firebase_auth` pour l'intégration backend.
    *   `go_router` pour la navigation.
    *   Dépendances de développement : `build_runner`, `riverpod_generator`, `riverpod_lint`.
2.  **Structure des dossiers :** Créer une architecture de dossiers orientée fonctionnalités (feature-first).
    ```
    lib/
    └── src/
        ├── features/
        │   ├── onboarding/
        │   └── game/
        ├── domain/
        │   ├── models/
        │   └── repositories/
        ├── data/
        └── presentation/
            ├── screens/
            ├── widgets/
            └── routing/
    ```
3.  **Point d'entrée :** Configurer `main.dart` avec le `ProviderScope` de Riverpod et initialiser un `MaterialApp` de base.
4.  **Navigation :** Mettre en place une configuration de base pour `go_router` avec une route initiale (`/`) pointant vers un écran d'accueil temporaire.

### Tests pour l'Étape 0 :
*   **Test de widget :** Vérifier que l'application se lance sans erreur et que l'écran d'accueil temporaire est bien affiché.

---

## Étape 1 : Phase 1 - Écrans et Logique du Questionnaire d'Onboarding

**Objectif :** Créer l'interface utilisateur permettant de recueillir les informations initiales.

1.  **Modèles de données :** Définir les classes pour le questionnaire (ex: `GiftProfile`).
2.  **Interface Utilisateur :** Construire l'écran du questionnaire. Utiliser un `PageView` ou un widget similaire pour afficher une question à la fois et rendre l'expérience fluide.
3.  **Gestion d'état :** Créer un `Notifier` Riverpod pour stocker les réponses de l'utilisateur au fur et à mesure.
4.  **Navigation :** À la fin du questionnaire, un bouton "Lancer la chasse" doit naviguer vers l'écran du jeu (qui sera un simple placeholder à ce stade).

### Tests pour l'Étape 1 :
*   **Test unitaire :** Tester le `Notifier` pour s'assurer que la sélection d'une réponse met correctement à jour l'état du `GiftProfile`.
*   **Test de widget :** Vérifier que l'interface du questionnaire s'affiche, que la sélection d'une option met à jour l'UI, et que le bouton de navigation fonctionne.

---

## Étape 2 : Modèles de Données et Service de Repository (Simulation)

**Objectif :** Définir le contrat de données pour les produits et simuler la récupération de données pour découpler l'UI du backend.

1.  **Modèle `Product` :** Créer la classe `Product` avec tous les champs nécessaires (id, nom, imageUrl, tags, lien d'affiliation, etc.).
2.  **Repository Abstrait :** Définir une classe abstraite `ProductRepository` qui expose les méthodes nécessaires (ex: `fetchInitialProducts(GiftProfile profile)`, `fetchNextProducts(Product chosenProduct)`).
3.  **Repository Simulé :** Implémenter une classe `FakeProductRepository` qui respecte l'interface et retourne des données codées en dur. Cela nous permettra de développer l'UI du jeu sans dépendre de Firebase.
4.  **Provider Riverpod :** Créer un provider qui expose l'implémentation du `ProductRepository` (pour l'instant, le `FakeProductRepository`).

### Tests pour l'Étape 2 :
*   **Test unitaire :** Vérifier que le `FakeProductRepository` retourne bien des listes de produits conformes aux attentes.

---

*Note : Les étapes suivantes seront détaillées une fois les précédentes complétées et validées.*
