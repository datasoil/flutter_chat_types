import 'package:meta/meta.dart';
import 'video_message.dart';

@immutable
class PartialVideo {
  /// Creates a partial video message with all variables video can have.
  /// Use [VideoMessage] to create a full message.
  /// You can use [VideoMessage.fromPartial] constructor to create a full
  /// message from a partial one.
  const PartialVideo({
    this.height,
    required this.length,
    required this.thumbUri,
    this.mimeType,
    required this.uri,
    this.width,
  });

  /// Creates a partial video message from a map (decoded JSON).
  PartialVideo.fromJson(Map<String, dynamic> json)
      : height = json['height']?.toDouble() as double?,
        width = json['width']?.toDouble() as double?,
        length = Duration(milliseconds: json['length'] as int),
        mimeType = json['mimeType'] as String?,
        thumbUri = json['thumbUri'] as String,
        uri = json['uri'] as String;

  /// Converts a partial video message to the map representation, encodable to JSON.
  Map<String, dynamic> toJson() => {
        'height': height,
        'width': width,
        'length': length,
        'mimeType': mimeType,
        'uri': uri,
        'thumbUri': thumbUri,
      };

  /// Image width in pixels
  final double? width;

  /// Image height in pixels
  final double? height;

  /// The length of the video
  final Duration length;

  /// Media type
  final String? mimeType;

  /// The video file source (either a remote URL or a local resource)
  final String uri;

  /// The preview video file source (either a remote URL or a local resource)
  final String thumbUri;
}
