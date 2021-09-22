import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_chat_types/src/messages/finish_message.dart';
import 'package:meta/meta.dart';
import 'messages/start_message.dart';
import 'messages/choice_message.dart';
import 'messages/activate_keyboard_message.dart';
import 'messages/file_message.dart';
import 'messages/image_message.dart';
import 'messages/question_message.dart';
import 'messages/text_message.dart';
import 'messages/video_message.dart';
import 'preview_data.dart' show PreviewData;
import 'user.dart' show User;

/// All possible message types.
enum MessageType {
  file,
  image,
  text,
  video,
  question,
  choice,
  start,
  media_activation,
  media_deactivation,
  fulfillment,
  keyboard_activation,
  cancel
}

/// Extension with one [toShortString] method
extension MessageTypeToShortString on MessageType {
  /// Converts enum to the string equal to enum's name
  String toShortString() {
    return toString().split('.').last;
  }
}

/// All possible statuses message can have.
enum Status { delivered, error, seen, sending, sent }

/// Extension with one [toShortString] method
extension StatusToShortString on Status {
  /// Converts enum to the string equal to enum's name
  String toShortString() {
    return toString().split('.').last;
  }
}

/// An abstract class that contains all variables and methods
/// every message will have.
@immutable
abstract class Message extends Equatable {
  const Message(
    this.author,
    this.createdAt,
    this.id,
    this.metadata,
    this.roomId,
    this.status,
    this.type,
    this.updatedAt,
  );

  /// Creates a particular message from a map (decoded JSON).
  /// Type is determined by the `type` field.
  factory Message.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    switch (type) {
      case 'video':
        return VideoMessage.fromJson(json);
      case 'file':
        return FileMessage.fromJson(json);
      case 'image':
        return ImageMessage.fromJson(json);
      case 'text':
        return TextMessage.fromJson(json);
      case 'question':
        return QuestionMessage.fromJson(json);
      case 'choice':
        return ChoiceMessage.fromJson(json);
      case 'start':
        return StartMessage.fromJson(json);
      case 'media_activation':
        return MediaActivationMessage.fromJson(json);
      case 'media_deactivation':
        return MediaDeactivationMessage.fromJson(json);
      case 'fulfillment':
        return FulfillmentMessage.fromJson(json);
      case 'keyboard_activation':
        return ActivateKeyboardMessage.fromJson(json);
      case 'cancel':
        return CancelMessage.fromJson(json);
      default:
        throw ArgumentError('Unexpected value for message type');
    }
  }

  /// Creates a copy of the message with an updated data
  /// [metadata] with null value will nullify existing metadata, otherwise
  /// both metadatas will be merged into one Map, where keys from a passed
  /// metadata will overwite keys from the previous one.
  /// [previewData] will be only set for the text message type.
  /// [status] with null value will be overwritten by the previous status.
  /// [text] will be only set for the text message type. Null value will be
  /// overwritten by the previous text (can't be empty).
  /// [updatedAt] with null value will nullify existing value.
  Message copyWith(
      {Map<String, dynamic>? metadata,
      PreviewData? previewData,
      Status? status,
      String? text,
      DateTime? updatedAt,
      String? roomId});

  /// Converts a particular message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson();

  /// User who sent this message
  final User author;

  /// Created message timestamp, in ms
  final DateTime? createdAt;

  /// Unique ID of the message
  final String id;

  /// Additional custom metadata or attributes related to the message
  final Map<String, dynamic>? metadata;

  /// ID of the room where this message is sent
  final String? roomId;

  /// Message [Status]
  final Status? status;

  /// [MessageType]
  final MessageType type;

  /// Updated message timestamp, in ms
  final DateTime? updatedAt;
}
