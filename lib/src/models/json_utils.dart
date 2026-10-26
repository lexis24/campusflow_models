/// Lit le champ [key] de [json] en vérifiant qu'il est présent et de type [T].
///
/// Lance une [FormatException] avec un message clair sinon. [model] sert
/// uniquement à indiquer dans le message quel modèle était en cours de lecture.
T readField<T>(Map<String, dynamic> json, String key, String model) {
  if (!json.containsKey(key) || json[key] == null) {
    throw FormatException('$model.fromJson : le champ "$key" est manquant.');
  }
  final value = json[key];
  if (value is! T) {
    throw FormatException(
      '$model.fromJson : le champ "$key" doit être de type $T, '
      'mais a reçu ${value.runtimeType} ($value).',
    );
  }
  return value;
}

/// Lit une date au format ISO 8601 (ex. "2026-11-02T18:00:00.000").
DateTime readDate(Map<String, dynamic> json, String key, String model) {
  final raw = readField<String>(json, key, model);
  final date = DateTime.tryParse(raw);
  if (date == null) {
    throw FormatException(
      '$model.fromJson : le champ "$key" n\'est pas une date ISO 8601 valide '
      '("$raw").',
    );
  }
  return date;
}
