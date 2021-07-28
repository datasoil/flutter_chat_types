import 'package:meta/meta.dart';
import 'choice_message.dart';

/// A class that represents partial choice message.
@immutable
class PartialChoice {
  /// Creates a partial choice message with all variables choice can have.
  /// Use [ChoiceMessage] to create a full message.
  /// You can use [ChoiceMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialChoice({
    required this.key,
    required this.text,
  });

  /// Creates a partial choice message from a map (decoded JSON).
  PartialChoice.fromJson(Map<String, dynamic> json)
      : key = json['key'] as String,
        text = json['text'] as String;

  /// Converts a partial choice message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'key': key,
        'text': text,
      };

  /// User's choice key
  final String key;

  /// User's choice text
  final String text;
}
