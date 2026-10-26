import 'dart:convert';

import '../models/course.dart';
import '../models/task.dart';
import '../models/user.dart';

/// Source de données de CampusFlow.
///
/// Simule un appel réseau : chaque méthode attend [delay] puis décode une
/// réponse JSON écrite en dur, comme le ferait un vrai client HTTP.
class CampusRepository {
  /// Durée simulée d'un appel réseau (1 seconde par défaut).
  final Duration delay;

  const CampusRepository({this.delay = const Duration(seconds: 1)});

  Future<User> fetchUser() async {
    await Future.delayed(delay);
    final json = jsonDecode(_userJson) as Map<String, dynamic>;
    return User.fromJson(json);
  }

  Future<List<Course>> fetchCourses() async {
    await Future.delayed(delay);
    final json = jsonDecode(_coursesJson) as List<dynamic>;
    return json
        .map((item) => Course.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Renvoie toutes les tâches, tous cours confondus.
  Future<List<Task>> fetchTasks() async {
    final courses = await fetchCourses();
    return courses.expand((course) => course.tasks).toList();
  }
}

// Réponses « serveur » écrites en dur.

const _userJson = '''
{
  "id": "u1",
  "name": "Alex Compaoré",
  "email": "alex.compaore@campus.fr"
}
''';

const _coursesJson = '''
[
  {
    "id": "c1",
    "title": "Développement mobile",
    "teacher": "Mme Diallo",
    "tasks": [
      {
        "id": "t1",
        "title": "TP modèles Dart",
        "description": "Créer les modèles Task, Course et User",
        "dueDate": "2026-11-02T18:00:00.000",
        "done": true,
        "courseId": "c1"
      },
      {
        "id": "t2",
        "title": "Tests unitaires",
        "description": "Écrire les tests copyWith et fromJson",
        "dueDate": "2026-11-09T18:00:00.000",
        "courseId": "c1"
      }
    ]
  },
  {
    "id": "c2",
    "title": "Intelligence artificielle",
    "teacher": "M. Martin",
    "tasks": [
      {
        "id": "t3",
        "title": "Projet réseau de neurones",
        "description": "Entraîner un MLP sur MNIST",
        "dueDate": "2026-11-20T23:59:00.000",
        "done": false,
        "courseId": "c2"
      }
    ]
  }
]
''';
