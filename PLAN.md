# Plan de Développement - GiftHunt

Ce document détaille les étapes incrémentales pour la construction de l'application GiftHunt. Chaque étape représente une fonctionnalité ou une couche technique distincte et doit être validée par des tests avant de passer à la suivante.

## Checklist Générale

- [x] Étape 0 : Configuration du Projet et Architecture de Base
- [x] Étape 1 : Phase 1 - Écrans et Logique du Questionnaire d'Onboarding
- [x] Étape 2 : Modèles de Données et Service de Repository (Simulation)
- [x] Étape 3 : Phase 2 - Interface du Jeu de Sélection ("L'entonnoir à idées")
- [x] Étape 4 : Logique du Jeu de Sélection avec Riverpod
- [x] Étape 5 : Configuration et Connexion à Firebase
- [x] Étape 6 : Intégration de Firestore pour les Produits
- [x] Étape 7 : Redirection vers le Site Partenaire
- [x] Étape 7.5 : Amélioration du Design et Thème de Couleurs
- [ ] Étape 8 : Stratégie de Récupération de Produits Amazon (Backend)
- [ ] Étape 9 : Authentification Utilisateur (Optionnelle)
- [ ] Étape 10 : Sauvegarde des "Chasses" pour les Utilisateurs Connectés


## Étape 0 : Configuration du Projet et Architecture de Base

**Objectif :** Mettre en place un squelette d'application sain et scalable.

1.  **Ajouter les dépendances :**
    *   `flutter_riverpod`, `riverpod_annotation` pour la gestion d'état.
    *   `firebase_core`, `cloud_firestore`, `firebase_auth` pour l'intégration backend.
    *   `go_router` pour la navigation.
    *   `freezed_annotation`, `json_annotation` pour la génération de code.
    *   Dépendances de développement : `build_runner`, `riverpod_generator`, `riverpod_lint`, `freezed`, `json_serializable`, `mocktail`.
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
*   **Test de compilation :** S'assurer que le projet compile sans erreur après l'ajout des dépendances et la configuration initiale.
*   **Test de widget :** Vérifier que l'application se lance sans erreur et que l'écran d'accueil temporaire est bien affiché.

---

## Étape 1 : Phase 1 - Écrans et Logique du Questionnaire d'Onboarding

**Objectif :** Créer l'interface utilisateur permettant de recueillir les informations initiales.

1.  **Modèles de données :** Définir la classe `GiftProfile` (avec `freezed`) pour stocker les intérêts, occasions, types de cadeaux et budget.
2.  **Interface Utilisateur :** Construire l'écran `OnboardingScreen` utilisant un `PageView` pour afficher une question à la fois.
    *   Créer un widget réutilisable `MultiChoiceQuestionWidget` pour les questions à choix multiples.
    *   Utiliser un `Slider` pour la question du budget.
3.  **Gestion d'état :** Créer un `Notifier` Riverpod (`GiftProfileNotifier`) pour stocker et mettre à jour les réponses de l'utilisateur au fur et à mesure.
4.  **Navigation :** À la fin du questionnaire, un bouton "Lancer la chasse" doit naviguer vers l'écran du jeu (`/game`).

### Tests pour l'Étape 1 :
*   **Test unitaire :** Tester le `Notifier` pour s'assurer que la sélection d'une réponse met correctement à jour l'état du `GiftProfile`.
*   **Test de widget :** Vérifier que l'interface du questionnaire s'affiche, que la sélection d'une option met à jour l'UI, et que le bouton de navigation fonctionne.

---

## Étape 2 : Modèles de Données et Service de Repository (Simulation)

**Objectif :** Définir le contrat de données pour les produits et simuler la récupération de données pour découpler l'UI du backend.

1.  **Modèle `Product` :** Créer la classe `Product` (avec `freezed` et `json_serializable`) avec les champs nécessaires (id, nom, imageUrl, tags, lien d'affiliation).
2.  **Repository Abstrait :** Définir une classe abstraite `ProductRepository` qui expose les méthodes nécessaires (`fetchInitialProducts(GiftProfile profile)`, `fetchNextProducts(Product chosenProduct)`).
3.  **Repository Simulé :** Implémenter une classe `FakeProductRepository` qui respecte l'interface `ProductRepository` et retourne des données codées en dur.
    *   `fetchInitialProducts` doit retourner 3 produits.
    *   `fetchNextProducts` doit retourner 2 produits.
4.  **Provider Riverpod :** Créer un provider (`productRepositoryProvider`) qui expose l'implémentation du `ProductRepository` (pour l'instant, le `FakeProductRepository`).

### Tests pour l'Étape 2 :
*   **Test unitaire :** Tester le `FakeProductRepository` pour s'assurer qu'il retourne bien des listes de produits conformes aux attentes.

---

## Étape 3 : Phase 2 - Interface du Jeu de Sélection ("L'entonnoir à idées")

**Objectif :** Créer l'interface utilisateur pour le jeu de sélection de produits.

1.  **Mise à jour de `GameScreen`** :
    *   Transformer `GameScreen` en `ConsumerStatefulWidget`.
    *   Utiliser un `GridView.builder` pour afficher les produits (3 par ligne).
    *   Chaque produit sera affiché dans une `Card` avec une image, un nom et des boutons d'action.
    *   Supprimer les boutons "Dislike" et "Like".
    *   Ajouter des boutons "Acheter sur Amazon" et "Voir sur Amazon" pour chaque produit.
    *   Implémenter un `InkWell` sur la carte du produit pour la sélection.
2.  **Gestion des interactions UI** : Afficher des `SnackBar` temporaires lors de la sélection d'un produit ou du clic sur les boutons d'action.

### Tests pour l'Étape 3 :
*   **Test de widget pour `GameScreen`** :
    *   Vérifier l'affichage du `CircularProgressIndicator` pendant le chargement.
    *   Vérifier que les 3 produits initiaux sont affichés correctement.
    *   Simuler le tap sur une carte de produit et vérifier l'affichage du `SnackBar` de sélection.
    *   Simuler le tap sur les boutons "Acheter sur Amazon" et "Voir sur Amazon" et vérifier l'affichage des `SnackBar` correspondants.

---

## Étape 4 : Logique du Jeu de Sélection avec Riverpod

**Objectif :** Implémenter la logique de sélection des produits et la gestion de l'état du jeu.

1.  **GameNotifier** : Créer un `Notifier` Riverpod (`GameNotifier`) pour gérer l'état des produits affichés et la logique de sélection.
    *   La méthode `build()` du `GameNotifier` doit récupérer les produits initiaux via `ProductRepository`.
    *   La méthode `selectProduct(Product chosenProduct, int chosenIndex)` doit :
        *   Mettre l'état du notificateur en `loading`.
        *   Appeler `productRepository.fetchNextProducts(chosenProduct)` pour obtenir deux nouveaux produits.
        *   Construire une nouvelle liste de 3 produits en plaçant `chosenProduct` à `chosenIndex` et les deux nouveaux produits dans les positions restantes.
        *   Mettre à jour l'état du notificateur avec la nouvelle liste de produits.
2.  **Mise à jour de `GameScreen`** :
    *   Utiliser `ref.watch(gameNotifierProvider)` pour observer l'état des produits.
    *   Appeler `gameNotifier.selectProduct(product, index)` lors du `onTap` sur un produit.
3.  **Mise à jour de `FakeProductRepository`** : S'assurer que `fetchNextProducts` renvoie seulement 2 produits.

### Tests pour l'Étape 4 :
*   **Test unitaire pour `GameNotifier`** :
    *   Vérifier que `build()` récupère les produits initiaux.
    *   Vérifier que `selectProduct` met à jour l'état avec le produit choisi à la bonne position et les nouveaux produits.
    *   Utiliser `mocktail` pour mocker `ProductRepository`.
*   **Test de widget pour `GameScreen`** :
    *   S'assurer que l'application affiche les produits initiaux.
    *   Simuler la sélection d'un produit et vérifier que l'affichage se met à jour avec le produit choisi et les nouveaux produits.
    *   Vérifier les interactions avec les boutons "Acheter sur Amazon" et "Voir sur Amazon".

---

## Étape 5 : Configuration et Connexion à Firebase

**Objectif :** Initialiser Firebase dans l'application Flutter.

1.  **Actions manuelles (utilisateur) :**
    *   Créer un projet Firebase sur la console Firebase.
    *   Enregistrer les applications Android, iOS et Web dans le projet Firebase.
    *   Télécharger les fichiers de configuration (`google-services.json`, `GoogleService-Info.plist`).
    *   Installer le CLI Firebase (`npm install -g firebase-tools`).
    *   Exécuter `flutterfire configure` depuis le répertoire racine du projet Flutter (`gifthunt/`).
2.  **Mise à jour de `main.dart` :**
    *   Importer `firebase_core/firebase_core.dart` et `firebase_options.dart`.
    *   Appeler `WidgetsFlutterBinding.ensureInitialized()` au début de `main()`.
    *   Appeler `await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);` avant `runApp()`.
3.  **Mise à jour de `pubspec.yaml` :** S'assurer que `firebase_core` et `cloud_firestore` sont inclus dans les dépendances.

### Tests pour l'Étape 5 :
*   **Vérification de la compilation :** S'assurer que l'application compile après l'initialisation de Firebase.
*   **Test de démarrage :** Lancer l'application pour vérifier qu'elle démarre sans erreur liée à Firebase.

---

## Étape 6 : Intégration de Firestore pour les Produits

**Objectif :** Remplacer le dépôt de produits simulé par une implémentation réelle utilisant Firestore.

1.  **Créer `FirestoreProductRepository` :**
    *   Implémenter une nouvelle classe `FirestoreProductRepository` qui étend `ProductRepository`.
    *   Utiliser `cloud_firestore` pour implémenter `fetchInitialProducts` et `fetchNextProducts`.
    *   `fetchInitialProducts` : Récupérer les 3 premiers produits d'une collection Firestore (ex: `products`).
    *   `fetchNextProducts` : Récupérer 2 nouveaux produits de Firestore, potentiellement basés sur des tags ou des catégories du `chosenProduct`.
2.  **Mettre à jour `product_providers.dart` :**
    *   Changer le `productRepositoryProvider` pour qu'il fournisse une instance de `FirestoreProductRepository`.
3.  **Mettre à jour les tests :**
    *   Supprimer `fake_product_repository_test.dart`.
    *   Adapter `game_notifier_test.dart` et `game_screen_test.dart` pour mocker `FirestoreProductRepository` ou utiliser une base de données Firestore de test (si applicable).

### Tests pour l'Étape 6 :
*   **Test unitaire pour `FirestoreProductRepository` :** (Nécessite un mock de Firestore ou une base de données de test)
    *   Vérifier que `fetchInitialProducts` renvoie les produits attendus.
    *   Vérifier que `fetchNextProducts` renvoie les produits attendus.
*   **Test de widget pour `GameScreen` :**
    *   S'assurer que l'application affiche les produits de Firestore.
    *   Vérifier que la sélection d'un produit déclenche la récupération de nouveaux produits depuis Firestore.

---

## Étape 7 : Redirection vers le Site Partenaire

**Objectif :** Implémenter la redirection vers les liens d'affiliation des produits.

1.  **Ajouter la dépendance `url_launcher` :** Inclure `url_launcher` dans `pubspec.yaml`.
2.  **Implémenter la logique de redirection :**
    *   Dans `GameScreen`, modifier les callbacks `onPressed` des boutons "Acheter sur Amazon" et "Voir sur Amazon".
    *   Utiliser `url_launcher` pour ouvrir `product.affiliationLink` ou une URL de produit Amazon construite.
3.  **Gestion des erreurs :** Ajouter une gestion des erreurs si l'URL ne peut pas être lancée.

### Tests pour l'Étape 7 :
*   **Test de widget pour `GameScreen` :**
    *   Simuler le tap sur les boutons "Acheter sur Amazon" et "Voir sur Amazon".
    *   Vérifier que `url_launcher` est appelé avec la bonne URL (nécessite un mock de `url_launcher`).

---

## Étape 7.5 : Amélioration du Design et Thème de Couleurs

**Objectif :** Moderniser l'interface utilisateur et appliquer un thème de couleurs cohérent.

1.  **Ajouter la dépendance `google_fonts` :** Inclure `google_fonts` dans `pubspec.yaml` pour des polices modernes.
2.  **Définir un Thème de Couleurs et Typographie :**
    *   Dans `main.dart`, définir une `ColorScheme` personnalisée avec des couleurs vibrantes et modernes.
    *   Utiliser `GoogleFonts` pour définir une typographie élégante pour l'ensemble de l'application.
    *   Appliquer ce thème au `MaterialApp` principal.
3.  **Mise à jour des Widgets existants :**
    *   **`OnboardingScreen` :**
        *   Styliser les `Text` pour utiliser la nouvelle typographie et les couleurs du thème.
        *   Améliorer l'apparence des `Card` et `ListTile` dans `MultiChoiceQuestionWidget` pour un look plus moderne (bordures arrondies, ombres subtiles, couleurs de sélection).
        *   Styliser le `Slider` pour correspondre au thème.
        *   Remplacer les `FloatingActionButton` par des `ElevatedButton` ou `FilledButton` stylisés avec les couleurs du thème.
    *   **`GameScreen` :**
        *   Styliser les `Card` des produits pour un design plus attrayant (bordures, ombres, coins arrondis).
        *   Améliorer l'affichage des images (placeholders plus esthétiques en cas d'erreur de chargement).
        *   Styliser les boutons "Acheter sur Amazon" et "Voir sur Amazon" pour qu'ils correspondent au thème.
        *   Ajouter des icônes pertinentes aux boutons.
4.  **Ajout d'éléments visuels :**
    *   Considérer l'ajout d'un arrière-plan subtil ou d'un dégradé sur certains écrans.
    *   Utiliser des icônes Material Design ou d'autres packs d'icônes si nécessaire.

### Tests pour l'Étape 7.5 :
*   **Vérification visuelle :** Lancer l'application en mode debug et inspecter visuellement les écrans pour s'assurer que le design est amélioré, que les couleurs sont appliquées correctement et que les icônes/images s'affichent comme prévu.
*   **Tests de widget existants :** S'assurer que les modifications de design n'ont pas cassé les fonctionnalités existantes et que les tests de widget précédents passent toujours.

## Étape 8 (Améliorée) : Stratégie Intelligente de Sélection de Produits via le Backend

**Objectif :** Définir et implémenter une stratégie en deux temps pour la sélection de produits : une recherche initiale large basée sur le questionnaire, suivie d'un affinage itératif basé sur les choix de l'utilisateur pour créer un véritable entonnoir de pertinence.

#### 1. Le Premier Appel : La Recherche Initiale (Post-Questionnaire)

Lorsque l'utilisateur valide le questionnaire de la Phase 1, l'application n'interroge pas directement Firestore. Elle appelle une fonction backend (ex: une Cloud Function `getInitialProducts`) avec le `GiftProfile` complet.

**Logique du Backend pour le premier appel :**

1.  **Traduction des Critères :** Le backend traduit le `GiftProfile` en une requête complexe pour l'API Amazon.
    *   **Centres d'intérêt (Tags) :** C'est le critère principal. Ils sont transformés en `Keywords` pour l'API. Si l'utilisateur a choisi "Geek" et "Gourmet", le backend ne cherche pas "Geek Gourmet", mais construit une recherche plus intelligente : `(cadeau geek) OR (cadeau gourmet)`.
    *   **Occasion & Relation :** Ces critères affinent les `Keywords`. Pour "Anniversaire" et "Père", les mots-clés deviennent `(cadeau anniversaire père geek) OR (cadeau anniversaire père gourmet)`. Cela augmente considérablement la pertinence.
    *   **Budget :** Ce critère est mappé directement sur `MinPrice` et `MaxPrice`.
    *   **Genre & Âge :** Ces critères sont plus subtils. Ils peuvent être utilisés pour affiner davantage les mots-clés (ex: "homme", "ado") ou pour filtrer les catégories de produits (`BrowseNodeId`) si Amazon le permet.

2.  **Stratégie de Diversification :** Pour la première proposition de 3 produits, le backend doit éviter de proposer trois fois la même chose. Il exécute donc plusieurs requêtes légèrement différentes pour assurer une diversité initiale :
    *   **Requête 1 :** Ciblée sur le premier centre d'intérêt (ex: `cadeau anniversaire père geek`).
    *   **Requête 2 :** Ciblée sur le second centre d'intérêt (ex: `cadeau anniversaire père gourmet`).
    *   **Requête 3 :** Une combinaison ou une idée plus large (ex: `cadeau original homme 50-100€`).

3.  **Enrichissement et Stockage :** Le backend récupère les meilleurs résultats de chaque requête, les **enrichit avec un système de tags internes** beaucoup plus granulaires que ceux de l'utilisateur (ex: un produit "Lego Star Wars" aura les tags `[lego, star-wars, geek, construction, film, collection, vaisseau-spatial]`), puis les stocke dans une collection temporaire ou les retourne directement à l'application.

#### 2. La Boucle d'Affinage : Apprendre de Chaque Clic

C'est ici que la magie opère. Quand l'utilisateur clique sur l'un des 3 produits, il ne fait pas qu'un simple choix. Il envoie un signal fort au backend sur ses préférences réelles.

**Logique du Backend pour les appels suivants (`getNextProducts`) :**

1.  **Analyse du Produit Choisi :** L'application envoie l'ID du produit choisi au backend. Le backend récupère ce produit depuis sa base de données (Firestore) et analyse sa liste de **tags internes enrichis**.
    *   *Exemple :* L'utilisateur a choisi le "Lego Faucon Millenium" parmi un livre de cuisine et un t-shirt geek. Le backend voit les tags : `[lego, star-wars, geek, construction, film, collection]`.

2.  **Déduction et Pondération :** Le backend en déduit que les tags `lego`, `star-wars`, et `construction` sont beaucoup plus pertinents que ce qu'il pensait initialement. Il augmente le "poids" de ces mots-clés pour les recherches futures.

3.  **Stratégie de "Plongée et Exploration" pour les 2 nouveaux produits :** Le backend ne cherche pas juste "d'autres produits Lego". Il génère deux nouvelles propositions avec des intentions différentes :

    *   **Proposition 1 (Plongée) :** Proposer un produit très similaire mais légèrement différent, pour affiner le besoin.
        *   **Requête :** `Keywords: "lego star wars x-wing" OR "lego technic"`, en utilisant les tags les plus forts du produit choisi. On reste dans le même micro-univers pour voir si c'est bien la marque `Lego` ou le thème `Star Wars` qui plaît.

    *   **Proposition 2 (Exploration) :** Proposer un produit qui partage des concepts ou des tags plus abstraits avec le produit choisi, pour élargir la découverte de manière pertinente.
        *   **Requête :** `Keywords: "maquette vaisseau spatial à construire" OR "figurine de collection film"`. Ici, on teste les concepts de `construction`, `collection` et `film` qui étaient aussi dans les tags du Lego, mais en dehors de l'univers Lego/Star Wars.

4.  **Mise à jour de l'UI :** Le backend retourne ces 2 nouveaux produits. L'application les affiche aux côtés du produit que l'utilisateur a conservé, créant ainsi l'effet d'entonnoir : "J'ai gardé ce que tu as aimé, et voici deux nouvelles idées basées sur ton choix."

---

## Étape 9 : Authentification Utilisateur (Optionnelle)

**Objectif :** Permettre aux utilisateurs de s'authentifier via Firebase Auth pour accéder à des fonctionnalités supplémentaires.

1.  **Implémenter le service d'authentification :**
    *   Créer un `AuthRepository` (abstrait) et une implémentation `FirebaseAuthRepository`.
    *   Inclure des méthodes pour l'inscription, la connexion (email/mot de passe, Google, etc.) et la déconnexion.
2.  **Créer un `Notifier` Riverpod pour l'authentification :**
    *   Gérer l'état de l'utilisateur (connecté/déconnecté, informations utilisateur).
    *   Exposer des méthodes pour les opérations d'authentification.
3.  **Intégrer l'authentification dans l'UI :**
    *   Ajouter des écrans de connexion/inscription.
    *   Mettre à jour la navigation (`go_router`) pour gérer les états d'authentification (redirection vers l'onboarding si non connecté, vers le jeu si connecté).

### Tests pour l'Étape 9 :
*   **Tests unitaires pour `AuthRepository` et `AuthNotifier` :**
    *   Vérifier les flux d'inscription, de connexion et de déconnexion.
    *   Mocker Firebase Auth pour les tests.
*   **Tests de widget pour les écrans d'authentification :**
    *   Vérifier l'affichage des formulaires.
    *   Simuler les interactions utilisateur et vérifier les changements d'état et la navigation.

---

## Étape 10 : Sauvegarde des "Chasses" pour les Utilisateurs Connectés

**Objectif :** Permettre aux utilisateurs connectés de sauvegarder leurs sessions de "chasse" (profils de cadeaux et produits sélectionnés).

1.  **Modèle `Hunt` :** Créer un modèle de données pour représenter une session de chasse (incluant `GiftProfile` et l'historique des produits sélectionnés).
2.  **Implémenter `HuntRepository` :**
    *   Créer un `FirestoreHuntRepository` pour sauvegarder et récupérer les sessions de chasse dans une sous-collection de l'utilisateur dans Firestore.
3.  **Intégrer la sauvegarde dans l'UI/Logique :**
    *   Ajouter un bouton "Sauvegarder la chasse" dans l'écran de jeu.
    *   Modifier le `GameNotifier` pour appeler le `HuntRepository` lors de la sauvegarde.
4.  **Afficher les chasses sauvegardées :**
    *   Créer un écran de profil ou un écran dédié pour lister les chasses sauvegardées par l'utilisateur.
    *   Permettre de recharger une chasse précédente pour la continuer ou la revoir.

### Tests pour l'Étape 10 :
*   **Tests unitaires pour `HuntRepository` :**
    *   Vérifier la sauvegarde et la récupération des sessions de chasse.
    *   Mocker Firestore.
*   **Tests de widget pour l'écran des chasses sauvegardées :**
    *   Vérifier l'affichage de la liste des chasses.
    *   Simuler la sélection d'une chasse et vérifier que l'application charge l'état correspondant.


