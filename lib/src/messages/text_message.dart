import 'package:meta/meta.dart';
import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import '../util.dart' show getStatusFromString;
import 'partial_text.dart';

/// A class that represents text message.
@immutable
class TextMessage extends Message {
  /// Creates a text message.
  const TextMessage({
    required User author,
    DateTime? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    this.previewData,
    String? roomId,
    Status? status,
    required this.text,
    DateTime? updatedAt,
  }) : super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.text,
          updatedAt,
        );

  /// Creates a full text message from a partial one.
  TextMessage.fromPartial({
    required User author,
    DateTime? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    required PartialText partialText,
    String? roomId,
    Status? status,
    DateTime? updatedAt,
  })  : previewData = null,
        text = partialText.text,
        super(
          author,
          createdAt,
          id,
          metadata,
          roomId,
          status,
          MessageType.text,
          updatedAt,
        );

  /// Creates a text message from a map (decoded JSON).
  TextMessage.fromJson(Map<String, dynamic> json)
      : previewData = json['previewData'] == null
            ? null
            : PreviewData.fromJson(json['previewData'] as Map<String, dynamic>),
        text = json['text'] as String,
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          json['roomId'] as String?,
          getStatusFromString(json['status'] as String?),
          MessageType.text,
          DateTime.fromMillisecondsSinceEpoch(json['updatedAt'] as int),
        );

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'createdAt': createdAt,
        'id': id,
        'metadata': metadata,
        'previewData': previewData?.toJson(),
        'roomId': roomId,
        'status': status?.toShortString(),
        'text': text,
        'type': MessageType.text.toShortString(),
        'updatedAt': updatedAt,
      };

  /// Creates a copy of the text message with an updated data
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [status] with null value will be overwritten by the previous status.
  /// [updatedAt] with null value will nullify existing value.
  @override
  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    Status? status,
    String? text,
    DateTime? updatedAt,
    String? roomId
  }) {
    return TextMessage(
      author: author,
      createdAt: createdAt,
      id: id,
      metadata: metadata == null
          ? null
          : {
              ...this.metadata ?? {},
              ...metadata,
            },
      previewData: previewData,
      roomId: roomId,
      status: status ?? this.status,
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
        previewData,
        roomId,
        status,
        text,
        updatedAt,
      ];

  /// See [PreviewData]
  final PreviewData? previewData;

  /// User's message
  final String text;
}
