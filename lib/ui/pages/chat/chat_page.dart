import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p_student_mobile/global/global_data.dart';
import 'package:p_student_mobile/model/message.dart';
import 'package:p_student_mobile/ui/pages/chat/chat_vm.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return ChatVM();
      },
      child: const ChatView(),
    );
  }
}


class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatVM>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("ĐOÀN TRƯỜNG")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: chatProvider.getChatStream(GlobalData.instance.uid!), // Replace 'clientUid' with the actual client UID
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                log("check data ${snapshot.data!.data()}");
                final messages = messagesFromMap(snapshot.data!.data()??{})??[];
                // return Container();
    
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final mes = messages[index];
                    Message message = Message(content: mes.content, isClient: mes.isClient);
                    return _buildMessageWidget(message);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(hintText: 'Type your message...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    await chatProvider.sendMessage(GlobalData.instance.uid!, _messageController.text);
                    _messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildMessageWidget(Message message) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    alignment: message.isClient ? Alignment.topRight : Alignment.topLeft,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      decoration: BoxDecoration(
        color: message.isClient ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message.content,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

}