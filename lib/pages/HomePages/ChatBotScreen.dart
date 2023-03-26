import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: appbar_builder(),
      body: Center(
        child: FloatingActionButton.extended(
          heroTag: "1234",
          onPressed: () => launchURL(),
          backgroundColor: Color(0xff5a43f3),
          label: AutoSizeText(
            "Launch bot",
            stepGranularity: 1.sp,
            minFontSize: 16.sp,
          ),
          icon: const Icon(Icons.message_rounded),
        ),
      )
    );
  }


  Future<void> launchURL() async {
    await launchUrl(Uri.parse("http://t.me/PropMateBot"), mode: LaunchMode.externalApplication);
  }

  AppBar appbar_builder() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 50.w,
      title: Padding(
        padding: EdgeInsets.only(
          left: 14,
          top: 16,
        ),
        child: Text("ChatBot",
            style: TextStyle(
                color: Colors.black,
                fontSize: 34.sp,
                fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
}
