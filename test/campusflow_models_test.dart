import 'package:campusflow_models/campusflow_models.dart';
import 'package:test/test.dart';

void main() {
  test('Task.done vaut false par défaut', () {
    final task = Task(
      id: 't1',
      title: 'TP Dart',
      description: 'Créer les modèles',
      dueDate: DateTime(2026, 11, 2),
      courseId: 'c1',
    );
    expect(task.done, isFalse);
  });
}
