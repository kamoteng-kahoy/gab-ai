import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';

class BookedMessage extends StatefulWidget {
  const BookedMessage({super.key});

  @override
  _BookedMessageState createState() => _BookedMessageState();
}

class _BookedMessageState extends State<BookedMessage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<String> messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text);
        _controller.clear();
      });
      _focusNode.requestFocus(); // Retain the keyboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Messages'),
        leading: IconButton(
        icon: const Icon(FluentIcons.arrow_left_20_filled), // Change this to any icon you prefer
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: ChatBubble(message: messages[index]),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      onSubmitted: (value) => _sendMessage(),
                      minLines: 1,
                      maxLines: null,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(FluentIcons.send_20_filled),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      decoration: BoxDecoration(
        color: SystemColors.primaryColorDarker,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.left,
      ),
    );
  }
}