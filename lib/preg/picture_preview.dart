import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gab_ai/colors.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class ImagePreviewScreen extends StatelessWidget {
  final String imagePath;

  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final fileName = path.basename(imagePath);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_20_filled),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(fileName,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: SystemColors.bgColorLighter,
      ),
      body: Container(
        color: SystemColors.bgColorLighter,
        child: Stack(
          children: [
            Center(
              child: Image.file(File(imagePath)),
            ),
          ],
        ),
      ),
    );
  }
}