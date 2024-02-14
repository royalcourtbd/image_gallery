import 'package:flutter/material.dart';
import 'package:image_gallery/presenter/image_model.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({super.key, required this.imageModel});
  final ImageModel imageModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        createRectTween: (begin, end) =>
            MaterialRectArcTween(begin: begin, end: end),
        tag: imageModel.id,
        child: Image.network(
          imageModel.imgUrl,
          fit: BoxFit.cover,
          height: double.infinity,
        ),
      ),
    );
  }
}
