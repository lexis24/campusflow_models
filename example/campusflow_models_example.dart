import 'package:campusflow_models/campusflow_models.dart';

void main() {
  const user = User(id: 'u1', name: 'Alex', email: 'alex@campus.fr');

  final task = Task(
    id: 't1',
    title: 'TP Dart',
    description: 'Créer les modèles CampusFlow',
    dueDate: DateTime(2026, 11, 2),
    courseId: 'c1',
  );

  final course = Course(
    id: 'c1',
    title: 'Développement mobile',
    teacher: 'M. Martin',
    tasks: [task],
  );

  print(user);
  print(course);
  print(task.copyWith(done: true));
}
