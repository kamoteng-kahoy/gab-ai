import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'dart:io'; // Import the dart:io package
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gab_ai/preg/appointments/picture_preview.dart';

class BookedMessage extends StatefulWidget {
  final String name;
  final String profilePicture;

  const BookedMessage({super.key, required this.name, required this.profilePicture});

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
  final ScrollController _scrollController = ScrollController();
  String? _filePath;
  String? _fileType;
  
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_scrollToBottom);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_scrollToBottom);
    _scrollController.dispose();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

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
      _scrollToBottom();
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
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profilePicture),
            ),
            const SizedBox(width: 15),
            Text(widget.name),
          ],
        ),
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
            child: SingleChildScrollView(
              controller: _scrollController,
              child: MessageList(messages: messages),
            ),
          ),
          MessageInput(
            controller: _controller,
            focusNode: _focusNode,
            onSendMessage: _sendMessage,
            onUploadFiles: _uploadFiles,
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
    // Get the keyboard height
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
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
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  final List<Message> messages;

  const MessageList({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
            return Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align the image to the right
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: SystemColors.primaryColorDarker,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImagePreviewScreen(imagePath: message.content),
                        ),
                      );
                    },
                    child: Image.file(
                      File(message.content),
                      width: 230, // Set the desired width
                      height: 200, // Set the desired height
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSendMessage;
  final VoidCallback onUploadFiles;

  const MessageInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSendMessage,
    required this.onUploadFiles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  onSubmitted: (value) => onSendMessage(),
                  minLines: 1,
                  maxLines: 5,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(FluentIcons.attach_20_filled),
            onPressed: onUploadFiles,
          ),
          IconButton(
            icon: const Icon(FluentIcons.send_20_filled),
            onPressed: onSendMessage,
          ),
        ],
      ),
    );
  }
}