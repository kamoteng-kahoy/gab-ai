import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;
  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final isVideo = imagePath.endsWith('.mp4'); // Check if the file is a video

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_20_filled),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          imagePath.split('/').last,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        backgroundColor: SystemColors.bgColorLighter,
        toolbarHeight: 80,
      ),
      body: Container(
        color: SystemColors.bgColorLighter,
        child: Stack(
          children: [
            Center(
              child: isVideo
                ? VideoPlayerWidget(videoPath: imagePath)
                : Image.file(File(imagePath)),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({super.key, required this.videoPath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isMuted = false; // Initial mute state

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.value.isInitialized) {
        setState(() {}); // Update the state to reflect the current position
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying ? _controller.pause() : _controller.play();
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_controller.value.isInitialized)
          GestureDetector(
            onTap: _togglePlayPause,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
        if (_controller.value.isInitialized)
          VideoProgressIndicator(_controller, allowScrubbing: true),
        if (_controller.value.isInitialized)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                onPressed: _togglePlayPause,
              ),
              Text(
                '${_controller.value.position.inMinutes}:${(_controller.value.position.inSeconds % 60).toString().padLeft(2, '0')} / ${_controller.value.duration.inMinutes}:${(_controller.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
              ),
              IconButton(
                icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                onPressed: _toggleMute,
              ),
            ],
          ),
        if (!_controller.value.isInitialized)
          const CircularProgressIndicator(),
      ],
    );
  }
}