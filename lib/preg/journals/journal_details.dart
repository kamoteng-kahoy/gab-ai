import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'package:intl/intl.dart';
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
        title: Text('Journal Details',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time Created: ',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    event['createdTime'] != null
                        ? DateFormat('yyyy-MM-dd    hh:mm a').format(event['createdTime'])
                        : 'No Time',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category:',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      event['category'] ?? 'No Category',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mood:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    event['mood'] ?? 'No Mood',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Food Intake:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: foodIntake.map((food) {
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(8.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            '${food['foodName']} - ${food['servings']} ${food['portion']}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Body:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8.0),
                SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      event['body'] ?? 'No Body',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
              ],
            ),
            const SizedBox(height: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attached Files:',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...attachedFiles.map((file) {
                        return Row(
                          children: [
                            _buildFileWidget(file),
                            const SizedBox(width: 8.0), // Add space between images
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
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
      // Simulate a delay to show the loading indicator
      return FutureBuilder<File>(
        future: Future.delayed(const Duration(seconds: 2), () => file),
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[100], // Placeholder color
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: SystemColors.textColor, // Set the color to black
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading image'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  snapshot.data!,
                  width: 200, // Set desired width
                  height: 200, // Set desired height
                  fit: BoxFit.cover, // Adjust the image to cover the container
                ),
              ),
            );
          }
        },
      );
    } else {
      // Handle other file types
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('Unsupported file type'),
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