# campusflow_models

Modèles de données de l'application mobile **CampusFlow**, écrits en Dart pur (sans Flutter).

CampusFlow aide un étudiant à suivre ses cours et les tâches (devoirs, projets, révisions) associées.
Ce package contient uniquement la couche « modèles » afin de pouvoir la tester et la réutiliser
indépendamment de l'interface.

## Contenu

| Élément | Rôle |
|---|---|
| `User` | Un utilisateur : `id`, `name`, `email` |
| `Course` | Un cours : `id`, `title`, `teacher` et la liste de ses `tasks` |
| `Task` | Une tâche : `id`, `title`, `description`, `dueDate`, `done`, `courseId` |
| `CampusRepository` | Simule un appel réseau (`Future`) et renvoie des modèles construits depuis du JSON |

Tous les modèles sont immuables (attributs `final`, constructeur `const`) et proposent
`copyWith`, `fromJson`, `toJson`, `toString`, `==` et `hashCode`.

## Prérequis

- [Dart SDK](https://dart.dev/get-dart) 3.x

## Installation

```bash
git clone https://github.com/lexis24/campusflow_models.git
cd campusflow_models
dart pub get
```

## Lancer l'exemple

```bash
dart run example/campusflow_models_example.dart
```

## Lancer les tests

```bash
dart test
```

## Vérifier la qualité du code

```bash
dart analyze
dart format .
```
