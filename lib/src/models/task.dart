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
