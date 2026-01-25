class Message {
  const Message({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      content: map['content'] as String,
      isUser: map['is_user'] as bool,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;
}
