import 'package:meta/meta.dart';
import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import '../util.dart' show getStatusFromString;
import 'partial_text.dart';

/// A class that represents the first message sent by the app to initialize the conversation.
@immutable
class StartMessage extends Message {
  /// Creates a text message.
  String? text;

  StartMessage(
      {required User author,
      int? createdAt,
      required String id,
      Map<String, dynamic>? metadata,
      String? roomId,
      Status? status,
      int? updatedAt,
      String? text})
      : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.start,
          updatedAt,
        );

  /// Creates a full text message from a partial one.
  StartMessage.fromPartial(
      {required User author,
      int? createdAt,
      required String id,
      Map<String, dynamic>? metadata,
      String? roomId,
      Status? status,
      int? updatedAt,
      String? text})
      : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.start,
          updatedAt,
        );

  /// Creates a text message from a map (decoded JSON).
  StartMessage.fromJson(Map<String, dynamic> json)
      : text = json['text'] as String?, 
      super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['createdAt'] as int?,
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          json['roomId'] as String?,
          getStatusFromString(json['status'] as String?),
          MessageType.start,
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
        'text': text,
        'type': MessageType.start.toShortString(),
        'updatedAt': updatedAt,
      };

  /// Creates a copy of the text message with an updated data
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [status] with null value will be overwritten by the previous status.
  /// [updatedAt] with null value will nullify existing value.
  @override
  Message copyWith(
      {Map<String, dynamic>? metadata,
      PreviewData? previewData,
      Status? status,
      String? text,
      int? updatedAt,
      String? roomId}) {
    return StartMessage(
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
        updatedAt: updatedAt,
        text: text);
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
        updatedAt,
      ];
}
