import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery/presenter/controller/home_controller.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  final List<String> _imageUrls = [
    // Add your image URLs here
    'https://www.celebsbooking.com/img/projects/sunny-slide-1.jpg',
    'https://www.celebsbooking.com/img/projects/sunny-slide-2.jpg',
    'https://www.celebsbooking.com/img/projects/sunny-slide-3.jpg',
    'https://pbs.twimg.com/media/Fuy0VkpaUAciEqW?format=jpg&name=large',
    'https://pbs.twimg.com/media/F1u3IyFaQAEnIE1?format=jpg&name=large',
    'https://pbs.twimg.com/media/FRzV97HWUAA3vlQ?format=jpg&name=large',
    'https://pbs.twimg.com/media/FHTdmM-WQAQaLfe?format=jpg&name=large',
    // Add more images as needed
  ];

  @override
  Widget build(BuildContext context) {
    log(homeController.images.length.toString());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: homeController.images.length,
          itemBuilder: (BuildContext context, int index) => ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Image.network(
              homeController.images[index].imgUrl,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index.isEven ? 2 : 3),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

HomeController homeController = HomeController.instance;
