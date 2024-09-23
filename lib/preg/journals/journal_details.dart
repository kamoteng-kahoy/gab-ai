import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class JournalDetails extends StatelessWidget {
  final Map<String, dynamic> event;

  const JournalDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final foodIntake = event['foodIntake'] as List<dynamic>? ?? [];
    final attachedFiles = event['attachedFiles'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: SystemColors.bgColorLighter,
      appBar: AppBar(
        title: Text('Event Details',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: SystemColors.bgColorLighter,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_20_filled),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Category:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 40.0,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          event['category'] ?? 'No Category',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Mood: ${event['mood'] ?? 'No Mood'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Food Intake:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ...foodIntake.map((food) {
                return Text(
                  '${food['foodName']} - ${food['servings']} ${food['portion']}',
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              }).toList(),
              const SizedBox(height: 8.0),
              Text(
                'Body: ${event['body'] ?? 'No Body'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Attached Files:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ...attachedFiles.map((file) {
                return _buildFileWidget(file);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileWidget(String filePath) {
    final file = File(filePath);
    final fileExtension = file.path.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
      // Display image
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.file(file,
          width: 300,
          height: 300,
          fit: BoxFit.cover,
        ),
      );
    } else if (['mp4', 'mov', 'avi', 'wmv'].contains(fileExtension)) {
      // Display video
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: VideoPlayerWidget(file: file),
      );
    } else {
      // Display other file types
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: const Icon(Icons.attach_file),
          title: Text(file.path.split(Platform.pathSeparator).last),
          onTap: () {
            // Handle file tap, e.g., open the file using a suitable app
          },
        ),
      );
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File file;

  const VideoPlayerWidget({super.key, required this.file});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const CircularProgressIndicator();
  }
}