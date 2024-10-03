import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';

class BookedMessage extends StatelessWidget {
  final String name;
  final String profilePicture;

  const BookedMessage({super.key, required this.name, required this.profilePicture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: AppBar(
        backgroundColor: SystemColors.bgColorLighter,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profilePicture),
            ),
            const SizedBox(width: 10),
            Text(name),
          ],
        ),
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_24_regular),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _handleSubmitted(String text) {
    _controller.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isSent: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        color: SystemColors.bgColorLighter,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _controller,
                  onSubmitted: _handleSubmitted,
                  maxLines: 7, // Allow the text field to grow vertically
                  minLines: 1, // Minimum number of lines
                  decoration: InputDecoration(
                    hintText: 'Send a message',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: SystemColors.textColorDarker,
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ), // Add border
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: SystemColors.textColorDarker,
                    fontSize: 16,
                  ),
                  scrollPadding: const EdgeInsets.all(20.0), // Add scroll padding
                ),
              ),
            ),
            IconButton(
              icon: const Icon(FluentIcons.attach_24_filled,
                color: SystemColors.textColorDarker,
              ),
              onPressed: () => print('Attach'),
            ),
            IconButton(
              icon: const Icon(FluentIcons.send_24_filled,
                color: SystemColors.textColorDarker,
              ),
              onPressed: () => _handleSubmitted(_controller.text),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        const Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          child: _buildTextComposer(),
        ),
      ],
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSent;

  const ChatMessage({super.key, required this.text, required this.isSent});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSent ? SystemColors.primaryColorDarker : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isSent ? const Radius.circular(15) : const Radius.circular(0),
            bottomRight: isSent ? const Radius.circular(0) : const Radius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSent ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}