/// Un utilisateur (étudiant) de CampusFlow.
class User {
  final String id;
  final String name;
  final String email;

  const User({required this.id, required this.name, required this.email});

  /// Renvoie un nouvel utilisateur identique, sauf pour les champs fournis.
  User copyWith({String? id, String? name, String? email}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          other.id == id &&
          other.name == name &&
          other.email == email;

  @override
  int get hashCode => Object.hash(id, name, email);
}
