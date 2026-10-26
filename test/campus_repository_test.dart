import 'package:campusflow_models/campusflow_models.dart';
import 'package:test/test.dart';

void main() {
  // Pas d'attente dans les tests pour qu'ils restent rapides.
  const repository = CampusRepository(delay: Duration.zero);

  group('CampusRepository', () {
    test('fetchUser renvoie l\'utilisateur', () async {
      final user = await repository.fetchUser();
      expect(user.id, 'u1');
    });

    test('fetchCourses renvoie les cours avec leurs tâches', () async {
      final courses = await repository.fetchCourses();
      expect(courses, hasLength(2));
      expect(courses.first.tasks, isNotEmpty);
    });

    test('fetchTasks renvoie les tâches de tous les cours', () async {
      final tasks = await repository.fetchTasks();
      expect(tasks.map((task) => task.id), ['t1', 't2', 't3']);
    });

    test('le délai par défaut simule un appel réseau d\'1 seconde', () async {
      final stopwatch = Stopwatch()..start();
      await const CampusRepository().fetchUser();
      expect(
        stopwatch.elapsed,
        greaterThanOrEqualTo(const Duration(seconds: 1)),
      );
    });
  });
}
