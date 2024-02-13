import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_gallery/firebase_options.dart';
import 'package:image_gallery/image_gallery.dart';

void main() async {
  await _init();
  runApp(const ImageGallery());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
