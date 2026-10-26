import 'task.dart';

/// Un cours suivi par l'étudiant, avec la liste de ses tâches.
class Course {
  final String id;
  final String title;
  final String teacher;
  final List<Task> tasks;

  const Course({
    required this.id,
    required this.title,
    required this.teacher,
    this.tasks = const [],
  });

  /// Renvoie un nouveau cours identique, sauf pour les champs fournis.
  Course copyWith({
    String? id,
    String? title,
    String? teacher,
    List<Task>? tasks,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      teacher: teacher ?? this.teacher,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  String toString() =>
      'Course(id: $id, title: $title, teacher: $teacher, tasks: $tasks)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          other.id == id &&
          other.title == title &&
          other.teacher == teacher &&
          _listEquals(other.tasks, tasks);

  @override
  int get hashCode => Object.hash(id, title, teacher, Object.hashAll(tasks));
}

/// Compare deux listes élément par élément (`==` sur une List ne compare
/// que les références).
bool _listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
