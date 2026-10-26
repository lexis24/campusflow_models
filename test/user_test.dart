import 'package:campusflow_models/campusflow_models.dart';
import 'package:test/test.dart';

void main() {
  const user = User(id: 'u1', name: 'Alex', email: 'alex@campus.fr');

  group('User', () {
    test('copyWith modifie un champ et laisse les autres inchangés', () {
      final updated = user.copyWith(email: 'nouveau@campus.fr');

      expect(updated.email, 'nouveau@campus.fr');
      expect(updated.id, user.id);
      expect(updated.name, user.name);
    });

    test('fromJson construit un utilisateur et lit chaque champ', () {
      final result = User.fromJson({
        'id': 'u2',
        'name': 'Awa',
        'email': 'awa@campus.fr',
      });

      expect(result.id, 'u2');
      expect(result.name, 'Awa');
      expect(result.email, 'awa@campus.fr');
    });

    test('fromJson avec un champ manquant lance une FormatException', () {
      expect(
        () => User.fromJson({'id': 'u1', 'name': 'Alex'}),
        throwsA(isA<FormatException>()),
      );
    });

    test('fromJson avec un mauvais type lance une FormatException', () {
      expect(
        () => User.fromJson({'id': 1, 'name': 'Alex', 'email': 'a@b.fr'}),
        throwsA(isA<FormatException>()),
      );
    });

    test('toJson puis fromJson redonne le même utilisateur', () {
      expect(User.fromJson(user.toJson()), user);
    });
  });
}
