import 'package:meta/meta.dart';
import '../../flutter_chat_types.dart';
import '../message.dart';
import '../user.dart' show User;
import '../util.dart' show getStatusFromString;
import 'partial_choice.dart';

/// A class that represents choice message.
@immutable
class ChoiceMessage extends Message {
  /// Creates a choice message.
  const ChoiceMessage({
    required User author,
    DateTime? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    String? roomId,
    Status? status,
    required this.key,
    required this.text,
    int? updatedAt,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.choice,
          updatedAt,
        );

  /// Creates a full text message from a partial one.
  ChoiceMessage.fromPartial({
    required User author,
    DateTime? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    required PartialChoice partialChoice,
    String? roomId,
    Status? status,
    int? updatedAt,
  })  : key = partialChoice.key,
        text = partialChoice.text,
        super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.choice,
          updatedAt,
        );

  /// Creates a text message from a map (decoded JSON).
  ChoiceMessage.fromJson(Map<String, dynamic> json)
      : key = json['key'] as String,
        text = json['text'] as String,
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['createdAt'] as DateTime?,
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          json['roomId'] as String?,
          getStatusFromString(json['status'] as String?),
          MessageType.choice,
          json['updatedAt'] as int?,
        );

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'createdAt': createdAt,
        'id': id,
        'metadata': metadata,
        'roomId': roomId,
        'status': status?.toShortString(),
        'key': key,
        'text': text,
        'type': MessageType.choice.toShortString(),
        'updatedAt': updatedAt,
      };

  /// Creates a copy of the text message with an updated data
  /// [metadata] with null text will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [status] with null text will be overwritten by the previous status.
  /// [updatedAt] with null text will nullify existing text.
  @override
  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    Status? status,
    String? text,
    int? updatedAt,
    String? roomId
  }) {
    return ChoiceMessage(
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
      key: key,
      text: text ?? this.text,
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
        key,
        text,
        updatedAt,
      ];

  /// User's choice key
  final String key;

  /// User's choice text
  final String text;
}
