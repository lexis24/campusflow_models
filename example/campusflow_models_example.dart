import 'package:campusflow_models/campusflow_models.dart';

Future<void> main() async {
  const repository = CampusRepository();

  print('Chargement des données...');

  // Les deux appels sont indépendants : on les lance en parallèle
  // (environ 1 seconde au total au lieu de 2).
  final userFuture = repository.fetchUser();
  final coursesFuture = repository.fetchCourses();
  final user = await userFuture;
  final courses = await coursesFuture;

  print('\nBonjour ${user.name} (${user.email}) !');

  for (final course in courses) {
    print('\n${course.title} — ${course.teacher}');
    for (final task in course.tasks) {
      final check = task.done ? 'x' : ' ';
      final date = task.dueDate.toIso8601String().substring(0, 10);
      print('  [$check] ${task.title} (pour le $date)');
    }
  }

  final tasks = await repository.fetchTasks();
  final remaining = tasks.where((task) => !task.done).length;
  print('\n$remaining tâche(s) restante(s) sur ${tasks.length}.');
}
