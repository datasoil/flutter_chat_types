import 'package:meta/meta.dart';
import '../../flutter_chat_types.dart';
import 'question_message.dart';

/// A class that represents partial question message.
@immutable
class PartialQuestion {
  /// Creates a partial question message with all variables quantion can have.
  /// Use [QuestionMessage] to create a full message.
  /// You can use [QuestionMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialQuestion({
    required this.question,
    required this.choices,
  });

  /// Creates a partial question message from a map (decoded JSON).
  PartialQuestion.fromJson(Map<String, dynamic> json)
      : question = json['question'] as String,
        choices = (json['choices'] as List<dynamic>)
            .map((obj) => Choice.fromJson(obj as Map<String, dynamic>))
            .toList();

  /// Converts a partial question message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'question': question,
        'choices': choices.map((e) => e.toJson()),
      };

  /// User's question
  final String question;

  ///Question's choices
  final List<Choice> choices;
}
