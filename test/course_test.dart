import 'package:campusflow_models/campusflow_models.dart';
import 'package:test/test.dart';

void main() {
  final courseJson = {
    'id': 'c1',
    'title': 'Développement mobile',
    'teacher': 'Mme Diallo',
    'tasks': [
      {
        'id': 't1',
        'title': 'TP Dart',
        'description': 'Créer les modèles',
        'dueDate': '2026-11-02T18:00:00.000',
        'done': false,
        'courseId': 'c1',
      },
    ],
  };

  group('Course', () {
    test('fromJson construit le cours et convertit ses tâches', () {
      final course = Course.fromJson(courseJson);

      expect(course.id, 'c1');
      expect(course.title, 'Développement mobile');
      expect(course.teacher, 'Mme Diallo');
      expect(course.tasks, hasLength(1));
      expect(course.tasks.first, isA<Task>());
      expect(course.tasks.first.id, 't1');
      expect(course.tasks.first.courseId, 'c1');
    });

    test('copyWith modifie un champ et laisse les autres inchangés', () {
      final course = Course.fromJson(courseJson);
      final updated = course.copyWith(teacher: 'M. Martin');

      expect(updated.teacher, 'M. Martin');
      expect(updated.id, course.id);
      expect(updated.title, course.title);
      expect(updated.tasks, course.tasks);
    });

    test('== compare les valeurs, y compris la liste de tâches', () {
      expect(Course.fromJson(courseJson), Course.fromJson(courseJson));
      expect(
        Course.fromJson(courseJson).hashCode,
        Course.fromJson(courseJson).hashCode,
      );
    });

    test('toJson puis fromJson redonne le même cours', () {
      final course = Course.fromJson(courseJson);
      expect(Course.fromJson(course.toJson()), course);
    });

    test('fromJson avec un champ manquant lance une FormatException', () {
      final json = Map<String, dynamic>.of(courseJson)..remove('teacher');
      expect(() => Course.fromJson(json), throwsA(isA<FormatException>()));
    });

    test('fromJson avec une tâche invalide lance une FormatException', () {
      final json = Map<String, dynamic>.of(courseJson)
        ..['tasks'] = [
          {'id': 't1'},
        ];
      expect(() => Course.fromJson(json), throwsA(isA<FormatException>()));
    });

    test('fromJson avec "tasks" qui n\'est pas une liste lance une '
        'FormatException', () {
      final json = Map<String, dynamic>.of(courseJson)..['tasks'] = 'aucune';
      expect(() => Course.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}
