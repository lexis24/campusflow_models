import 'package:campusflow_models/campusflow_models.dart';
import 'package:test/test.dart';

void main() {
  final task = Task(
    id: 't1',
    title: 'TP Dart',
    description: 'Créer les modèles',
    dueDate: DateTime(2026, 11, 2, 18),
    courseId: 'c1',
  );

  group('Task', () {
    test('done vaut false par défaut', () {
      expect(task.done, isFalse);
    });

    test('copyWith modifie un champ et laisse les autres inchangés', () {
      final updated = task.copyWith(done: true);

      expect(updated.done, isTrue);
      expect(updated.id, task.id);
      expect(updated.title, task.title);
      expect(updated.description, task.description);
      expect(updated.dueDate, task.dueDate);
      expect(updated.courseId, task.courseId);
      // L'original n'a pas changé (immuabilité).
      expect(task.done, isFalse);
    });

    test('fromJson construit une tâche et lit chaque champ', () {
      final result = Task.fromJson({
        'id': 't2',
        'title': 'Exposé',
        'description': 'Préparer les slides',
        'dueDate': '2026-11-09T18:00:00.000',
        'done': true,
        'courseId': 'c2',
      });

      expect(result.id, 't2');
      expect(result.title, 'Exposé');
      expect(result.description, 'Préparer les slides');
      expect(result.dueDate, DateTime(2026, 11, 9, 18));
      expect(result.done, isTrue);
      expect(result.courseId, 'c2');
    });

    test('fromJson sans "done" utilise false', () {
      final json = task.toJson()..remove('done');
      expect(Task.fromJson(json).done, isFalse);
    });

    test('toJson puis fromJson redonne la même tâche', () {
      expect(Task.fromJson(task.toJson()), task);
    });

    test('fromJson avec un champ manquant lance une FormatException', () {
      final json = task.toJson()..remove('title');
      expect(() => Task.fromJson(json), throwsA(isA<FormatException>()));
    });

    test('fromJson avec un mauvais type lance une FormatException', () {
      final json = task.toJson()..['dueDate'] = 42;
      expect(() => Task.fromJson(json), throwsA(isA<FormatException>()));
    });

    test('fromJson avec une date invalide lance une FormatException', () {
      final json = task.toJson()..['dueDate'] = 'pas une date';
      expect(() => Task.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}
