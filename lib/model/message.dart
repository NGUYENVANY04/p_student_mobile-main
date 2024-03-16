class Message {
  final String content;
  final bool isClient;

  Message({required this.content, required this.isClient});

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['content'] ?? '',
      isClient: map['sender'] == 'client',
    );
  }
}

List<Message>? messagesFromMap(Map<String, dynamic> map) {
  return map.entries.map((entry) {
    return Message.fromMap(entry.value as Map<String, dynamic>);
  }).toList();
}

