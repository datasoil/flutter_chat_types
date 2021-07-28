import 'package:meta/meta.dart';
import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import '../util.dart' show getStatusFromString;
import 'partial_video.dart';

/// A class that represents video message.
@immutable
class VideoMessage extends Message {
  /// Creates an video message.
  const VideoMessage({
    required User author,
    int? createdAt,
    required this.length,
    required String id,
    Map<String, dynamic>? metadata,
    String? roomId,
    this.mimeType,
    Status? status,
    int? updatedAt,
    required this.uri,
    required this.thumbUri,
  }) : super(author, createdAt, id, metadata, roomId, status, MessageType.video,
            updatedAt);

  /// Creates a full video message from a partial one.
  VideoMessage.fromPartial({
    required User author,
    int? createdAt,
    required String id,
    Map<String, dynamic>? metadata,
    required PartialVideo partialVideo,
    String? roomId,
    Status? status,
    int? updatedAt,
  })  : length = partialVideo.length,
        mimeType = partialVideo.mimeType,
        uri = partialVideo.uri,
        thumbUri = partialVideo.thumbUri,
        super(author, createdAt, id, metadata, roomId, status,
            MessageType.video, updatedAt);

  /// Creates an video message from a map (decoded JSON).
  VideoMessage.fromJson(Map<String, dynamic> json)
      : length = Duration(milliseconds: json['length'] as int),
        mimeType = json['mimeType'] as String?,
        uri = json['uri'] as String,
        thumbUri = json['thumbUri'] as String,
        super(
          User.fromJson(json['author'] as Map<String, dynamic>),
          json['createdAt'] as int?,
          json['id'] as String,
          json['metadata'] as Map<String, dynamic>?,
          json['roomId'] as String?,
          getStatusFromString(json['status'] as String?),
          MessageType.video,
          json['updatedAt'] as int?,
        );

  /// Converts an video message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => {
        'author': author.toJson(),
        'createdAt': createdAt,
        'id': id,
        'metadata': metadata,
        'roomId': roomId,
        'length': length.inMilliseconds,
        'mimeType': mimeType,
        'status': status?.toShortString(),
        'type': MessageType.video.toShortString(),
        'updatedAt': updatedAt,
        'uri': uri,
        'thumbUri': thumbUri,
      };

  /// Creates a copy of the video message with an updated data
  @override
  Message copyWith({
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    Status? status,
    String? text,
    int? updatedAt,
  }) {
    return VideoMessage(
        author: author,
        createdAt: createdAt,
        length: length,
        id: id,
        metadata: metadata == null
            ? null
            : {
                ...this.metadata ?? {},
                ...metadata,
              },
        mimeType: mimeType,
        status: status ?? this.status,
        updatedAt: updatedAt,
        uri: uri,
        thumbUri: thumbUri);
  }

  /// Equatable props
  @override
  List<Object?> get props => [
        author,
        length,
        id,
        metadata,
        mimeType,
        status,
        updatedAt,
        uri,
        thumbUri
      ];

  /// The length of the video
  final Duration length;

  /// Media type
  final String? mimeType;

  /// The video source (either a remote URL or a local resource)
  final String uri;

  /// The preview video source (either a remote URL or a local resource)
  final String thumbUri;
}
