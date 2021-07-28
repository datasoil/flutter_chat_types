import 'package:flutter_chat_types/src/choice.dart';
import 'package:meta/meta.dart';
import '../../flutter_chat_types.dart';
import '../message.dart';
import '../user.dart' show User;
import '../util.dart' show getStatusFromString;
import 'partial_question.dart';

/// A class that represents question message.
@immutable
class QuestionMessage extends Message {
  /// Creates a question message.
  const QuestionMessage({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    String? roomId,
    Status? status,
    required this.question,
    required this.choices,
    int? updatedAt,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.question,
          updatedAt,
        );

  /// Creates a full question message from a partial one.
  QuestionMessage.fromPartial({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    required PartialQuestion partialQuestion,
    String? roomId,
    Status? status,
    int? updatedAt,
  })  : question = partialQuestion.question,
        choices = partialQuestion.choices,
        super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.question,
          updatedAt,
        );

  /// Creates a question message from a map (decoded JSON).
  QuestionMessage.fromJson(Map<String, dynamic> json)
      : question = json['question'] as String,
        choices = (json['choices'] as List<dynamic>)
            .map((obj) => Choice.fromJson(obj as Map<String, dynamic>))
            .toList(),
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['createdAt'] as int?,
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          json['roomId'] as String?,
          getStatusFromString(json['status'] as String?),
          MessageType.question,
          json['updatedAt'] as int?,
        );

  /// Converts a question message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'createdAt': createdAt,
        'id': id,
        'metadata': metadata,
        'roomId': roomId,
        'status': status?.toShortString(),
        'question': question,
        'choices': choices.map((e) => e.toJson()).toList(),
        'type': MessageType.question.toShortString(),
        'updatedAt': updatedAt,
      };

  /// Creates a copy of the question message with an updated data
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [status] with null value will be overwritten by the previous status.
  /// [updatedAt] with null value will nullify existing value.

  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    Status? status,
    String? text,
    int? updatedAt,
    List<Choice>? choices,
  }) {
    return QuestionMessage(
      author: author,
      createdAt: createdAt,
      id: id,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      roomId: roomId,
      status: status ?? this.status,
      question: question,
      choices: choices ?? this.choices,
      updatedAt: updatedAt,
    );
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        author,
        createdAt,
        id,
        metadata,
        roomId,
        status,
        question,
        choices,
        updatedAt,
      ];

  /// User's question
  final String question;

  ///Question's choices
  final List<Choice> choices;
}
