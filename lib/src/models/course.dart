import 'json_utils.dart';
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

  /// Construit un cours depuis un JSON, y compris sa liste de tâches.
  ///
  /// `tasks` est facultatif (liste vide par défaut). Lance une
  /// [FormatException] si un champ obligatoire manque ou a un mauvais type.
  factory Course.fromJson(Map<String, dynamic> json) {
    final rawTasks = json['tasks'] ?? const <dynamic>[];
    if (rawTasks is! List) {
      throw FormatException(
        'Course.fromJson : le champ "tasks" doit être une liste, '
        'mais a reçu ${rawTasks.runtimeType}.',
      );
    }
    return Course(
      id: readField<String>(json, 'id', 'Course'),
      title: readField<String>(json, 'title', 'Course'),
      teacher: readField<String>(json, 'teacher', 'Course'),
      tasks: rawTasks.map((item) {
        if (item is! Map<String, dynamic>) {
          throw FormatException(
            'Course.fromJson : chaque élément de "tasks" doit être un objet '
            'JSON, mais a reçu ${item.runtimeType}.',
          );
        }
        return Task.fromJson(item);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'teacher': teacher,
    'tasks': tasks.map((task) => task.toJson()).toList(),
  };

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
