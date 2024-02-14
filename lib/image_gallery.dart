import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery/presenter/ui/home_page.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Image Gallery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: AllControllerBinding(),
      home: const HomePage(),
    );
  }
}
