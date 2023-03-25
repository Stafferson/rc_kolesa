import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = ['Hello, how can I assist you?'];

  void _sendMessage(String message) {
    setState(() {
      _messages.add(message);
    });
    // Call chatbot API to get response
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Incident-Manager Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(labelText: 'Type your message'),
            onFieldSubmitted: (value) {
              _sendMessage(value);
              _messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
