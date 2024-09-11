import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'dart:io'; // Import the dart:io package
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:file_picker/file_picker.dart';

class BookedMessage extends StatefulWidget {
  const BookedMessage({super.key});

  @override
  _BookedMessageState createState() => _BookedMessageState();
}

class Message {
  final String type;
  final String content;
  final String? fileType;

  Message({required this.type, required this.content, this.fileType});
}

class _BookedMessageState extends State<BookedMessage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<Message> messages = [];
  String? _filePath;
  String? _fileType;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        if (_filePath != null && _fileType != null) {
          messages.add(Message(type: 'file', content: _filePath!, fileType: _fileType));
          _filePath = null;
          _fileType = null;
        } else {
          messages.add(Message(type: 'text', content: _controller.text));
        }
        _controller.clear();
      });
      _focusNode.requestFocus(); // Retain the keyboard
    }
  }

  void _uploadFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _controller.text = file.name; // Show file name in the text box
        _filePath = file.path;
        _fileType = file.extension;
      });
      print(file.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: AppBar(
        backgroundColor: SystemColors.bgColorLighter,
        toolbarHeight: 70,
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
                final message = messages[index];
                if (message.type == 'text') {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: ChatBubble(message: message.content)),
                    ],
                  );
                } else if (message.type == 'file') {
                  if (message.fileType == 'jpg' || message.fileType == 'png') {
                    return ListTile(
                      title: Image.file(File(message.content)),
                    );
                  }
                }
                return SizedBox.shrink();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
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
                  icon: const Icon(FluentIcons.attach_20_filled),
                  onPressed: _uploadFiles,
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
        textAlign: TextAlign.right,
      ),
    );
  }
}