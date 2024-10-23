import 'dart:async';

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
    final isVideo = imagePath.endsWith('.mp4');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent, // Removes shadow when scrolling
        scrolledUnderElevation: 0, // Prevents shadow when scrolling
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
        toolbarHeight: 70,
      ),
      body: Container(
        color: SystemColors.bgColorLighter,
        child: Center(
          child: isVideo
            ? VideoPlayerWidget(videoPath: imagePath)
            : PortraitAwareImage(imagePath: imagePath),
        ),
      ),
    );
  }
}

class PortraitAwareImage extends StatelessWidget {
  final String imagePath;

  const PortraitAwareImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Size>(
      future: _getImageSize(imagePath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final size = snapshot.data!;
          final isPortrait = size.height > size.width;
          return AspectRatio(
            aspectRatio: isPortrait ? size.width / size.height : size.height / size.width,
            child: Image.file(File(imagePath)),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<Size> _getImageSize(String path) async {
    final image = Image.file(File(path));
    final completer = Completer<Size>();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(info.image.width.toDouble(), info.image.height.toDouble()));
      }),
    );
    return completer.future;
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
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.value.isInitialized) {
        setState(() {});
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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!_controller.value.isInitialized) {
          return const CircularProgressIndicator();
        }

        final videoRatio = _controller.value.aspectRatio;
        final screenRatio = constraints.maxWidth / constraints.maxHeight;

        double videoWidth, videoHeight;
        if (videoRatio > screenRatio) {
          videoWidth = constraints.maxWidth;
          videoHeight = videoWidth / videoRatio;
        } else {
          videoHeight = constraints.maxHeight * 0.7; // Use 70% of available height
          videoWidth = videoHeight * videoRatio;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _togglePlayPause,
              child: SizedBox(
                width: videoWidth,
                height: videoHeight,
                child: VideoPlayer(_controller),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: VideoProgressIndicator(_controller, allowScrubbing: true),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
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
          ],
        );
      },
    );
  }
}