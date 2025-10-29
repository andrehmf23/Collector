import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget buildImage(String? path, double size, {Color? color}) {
  if (path == null || path.isEmpty) return Icon(Icons.camera_alt, color: color, size: size);

  print("Path: $path");

  if (kIsWeb) {
    return Image.network(path, fit: BoxFit.cover);
  } else {
    return Image.file(File(path), fit: BoxFit.cover);
  }
}