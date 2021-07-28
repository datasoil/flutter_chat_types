import 'package:meta/meta.dart';

@immutable
class Choice {
  const Choice({required this.key, required this.text});

  /// Creates a question message from a map (decoded JSON).
  Choice.fromJson(Map<String, dynamic> json)
      : key = json['key'] as String,
        text = json['text'] as String;

  final String key;
  final String text;

  @override
  String toString() {
    return '{key: $key, text: $text}';
  }

  Map<String, dynamic> toJson() => {'key': key, 'text': text};
}
