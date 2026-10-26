import 'json_utils.dart';

/// Une tâche à réaliser dans le cadre d'un cours (devoir, projet, révision...).
class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool done;

  /// Identifiant du [Course] auquel la tâche appartient.
  final String courseId;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.done = false,
    required this.courseId,
  });

  /// Construit une tâche depuis un JSON.
  ///
  /// `done` est facultatif (false par défaut). Lance une [FormatException]
  /// si un champ obligatoire manque ou a un mauvais type.
  factory Task.fromJson(Map<String, dynamic> json) {
    final done = json['done'];
    if (done != null && done is! bool) {
      throw FormatException(
        'Task.fromJson : le champ "done" doit être de type bool, '
        'mais a reçu ${done.runtimeType} ($done).',
      );
    }
    return Task(
      id: readField<String>(json, 'id', 'Task'),
      title: readField<String>(json, 'title', 'Task'),
      description: readField<String>(json, 'description', 'Task'),
      dueDate: readDate(json, 'dueDate', 'Task'),
      done: done as bool? ?? false,
      courseId: readField<String>(json, 'courseId', 'Task'),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate.toIso8601String(),
    'done': done,
    'courseId': courseId,
  };

  /// Renvoie une nouvelle tâche identique, sauf pour les champs fournis.
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? done,
    String? courseId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      done: done ?? this.done,
      courseId: courseId ?? this.courseId,
    );
  }

  @override
  String toString() =>
      'Task(id: $id, title: $title, description: $description, '
      'dueDate: ${dueDate.toIso8601String()}, done: $done, courseId: $courseId)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          other.id == id &&
          other.title == title &&
          other.description == description &&
          other.dueDate == dueDate &&
          other.done == done &&
          other.courseId == courseId;

  @override
  int get hashCode =>
      Object.hash(id, title, description, dueDate, done, courseId);
}
