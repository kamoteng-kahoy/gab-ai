import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gab_ai/preg/appointments/picture_preview.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

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
        title: InkWell(
          onTap: () {
            print('Appbar tapped');
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profilePicture),
                radius: 20,
              ),
              const SizedBox(width: 20),
              Text(name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 20,
                ), 
              ),
            ],
          ),
        ),
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_24_regular),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(FluentIcons.more_vertical_24_regular),
            onPressed: () {
              // Add your onPressed code here!
            },
          ),
        ],
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
  File? _selectedFile;
  VideoPlayerController? _videoController;

  void _handleSubmitted(String text) {
    _controller.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isSent: true,
      file: _selectedFile,
      videoController: _videoController,
    );
    setState(() {
      _messages.insert(0, message);
      _selectedFile = null;
      _videoController = null;
    });
  }

  Future<void> _handleAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _controller.text = result.files.single.name; // Show only the file name
        if (_selectedFile!.path.endsWith('.mp4')) {
          _videoController = VideoPlayerController.file(_selectedFile!)
            ..initialize().then((_) {
              setState(() {});
            });
        }
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
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
              onPressed: _handleAttachment,
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
  final File? file;
  final VideoPlayerController? videoController;

  const ChatMessage({super.key, required this.text, required this.isSent, this.file, this.videoController});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (file != null)
              file!.path.endsWith('.mp4')
                  ? videoController != null && videoController!.value.isInitialized
                      ? GestureDetector(
                          onTap: () {
                            print('Video');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImagePreviewScreen(imagePath: file!.path),
                              ),
                            );
                          },
                          child: AspectRatio(
                            aspectRatio: videoController!.value.aspectRatio,
                            child: VideoPlayer(videoController!),
                          ),
                        )
                      : FutureBuilder(
                          future: videoController!.initialize(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return GestureDetector(
                                onTap: () {
                                  print('Video');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImagePreviewScreen(imagePath: file!.path),
                                    ),
                                  );
                                },
                                child: AspectRatio(
                                  aspectRatio: videoController!.value.aspectRatio,
                                  child: VideoPlayer(videoController!),
                                ),
                              );
                            } else {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                height: MediaQuery.of(context).size.height * 0.3,
                                child: const Center(child: CircularProgressIndicator()),
                              );
                            }
                          },
                        )
                  : GestureDetector(
                      onTap: () {
                        print('Image');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImagePreviewScreen(imagePath: file!.path),
                          ),
                        );
                      },
                      child: Image.file(
                        file!,
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ),
            if (file == null && text.isNotEmpty)
              Text(
                text,
                style: TextStyle(
                  color: isSent ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}