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
        title: Row(
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
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_24_regular),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          PopupMenuTheme(
            data: PopupMenuThemeData(
              color: SystemColors.accentColor2,
              textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                color: SystemColors.textColorDarker
              ),
            ),
            child: PopupMenuButton<String>(
              icon: const Icon(FluentIcons.more_vertical_24_regular),
              onSelected: (String result) {
                switch (result) {
                  case 'profile':
                    _handleprofile();
                    break;
                  case 'delete':
                    _handledelete();
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      const Icon(FluentIcons.person_circle_20_filled, color: Colors.black),
                      const SizedBox(width: 15),
                      Text('Profile',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(FluentIcons.delete_20_filled, color: Colors.black),
                      const SizedBox(width: 15),
                      Text('Delete',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: const ChatScreen(),
    );
  }

  void _handleprofile() {
    print('option 1');
  }

  void _handledelete() {
    print('option 2');
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
  bool _isLoading = false; // Add this line

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
      _isLoading = false; // Reset loading state
    });
  }

  Future<void> _handleAttachment() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        if (_selectedFile!.path.endsWith('.mp4')) {
          _videoController = VideoPlayerController.file(_selectedFile!)
            ..initialize().then((_) {
              setState(() {
                _isLoading = false; // Set loading state to false
              });
            });
        } else {
          _isLoading = false; // Set loading state to false
        }
        _controller.text = result.files.single.name; // Show only the file name
      });
    } else {
      setState(() {
        _isLoading = false; // Set loading state to false if no file is selected
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
                    hintText: _isLoading ? 'Loading media...' : 'Send a message', // Change hint text based on loading state
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
                  enabled: !_isLoading, // Disable text field when loading
                ),
              ),
            ),
            IconButton(
              icon: const Icon(FluentIcons.attach_24_filled,
                color: SystemColors.textColorDarker,
              ),
              onPressed: _isLoading ? null : _handleAttachment, // Disable button when loading
            ),
            IconButton(
              icon: const Icon(FluentIcons.send_24_filled,
                color: SystemColors.textColorDarker,
              ),
              onPressed: _isLoading ? null : () => _handleSubmitted(_controller.text), // Disable button when loading
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: file != null
            ? _buildMediaContent(context)
            : _buildTextBubble(context),
      ),
    );
  }

  Widget _buildMediaContent(BuildContext context) {
    if (file!.path.endsWith('.mp4')) {
      return _buildVideoContent(context);
    } else {
      return _buildImageContent(context);
    }
  }

  Widget _buildVideoContent(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPreviewScreen(context),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double aspectRatio = videoController?.value.aspectRatio ?? 16 / 9;
          bool isLandscape = aspectRatio > 1;
          double width = isLandscape
              ? MediaQuery.of(context).size.width * 0.7 // 50% of screen width for landscape
              : MediaQuery.of(context).size.width * 0.5; // 25% of screen width for portrait
          double height = width / aspectRatio;

          return ClipRRect(
            borderRadius: BorderRadius.circular(12.0), // Add circular border radius
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: width,
                  height: height,
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: videoController != null && videoController!.value.isInitialized
                        ? VideoPlayer(videoController!)
                        : Container(color: Colors.black),
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
                Icon(
                  FluentIcons.play_circle_48_filled,
                  size: isLandscape ? 48 : 36,
                  color: Colors.white.withOpacity(0.8),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageContent(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPreviewScreen(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0), // Add circular border radius
        child: Image.file(
          file!,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * 0.5, // 50% of screen width
          height: MediaQuery.of(context).size.width * 0.55, // Square aspect ratio
        ),
      ),
    );
  }

  Widget _buildTextBubble(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: isSent ? SystemColors.primaryColorDarker : Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15),
          topRight: const Radius.circular(15),
          bottomLeft: isSent ? const Radius.circular(15) : const Radius.circular(0),
          bottomRight: isSent ? const Radius.circular(0) : const Radius.circular(15),
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
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

  void _openPreviewScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(imagePath: file!.path),
      ),
    );
  }
}