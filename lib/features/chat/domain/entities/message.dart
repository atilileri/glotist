/// Represents a message in the chat.
class Message {
  /// Creates a [Message] instance.
  const Message({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
  });

  /// Creates a [Message] from a map.
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      content: map['content'] as String,
      isUser: map['is_user'] as bool,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }

  /// The unique identifier for the message.
  final String id;

  /// The text content of the message.
  final String content;

  /// Whether the message was sent by the user.
  final bool isUser;

  /// The timestamp when the message was sent.
  final DateTime timestamp;
}
