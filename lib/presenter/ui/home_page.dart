import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_gallery/presenter/ui/privacy_policy.dart';
import 'package:image_gallery/presenter/ui/view_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log(homeController.images.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
        centerTitle: true,
        backgroundColor: const Color(0xffF4C2C2),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add),
        //     onPressed: () => controller.addImage(),
        //   ),
        // ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xffF4C2C2),
              ),
              child: Center(
                child: Image.asset('assets/images/splash_icon.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.policy),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                !homeController.isLoadingMore) {
              homeController.fetchMoreImages();
            }
            return false;
          },
          child: Obx(
            () => homeController.images.isEmpty
                ? Center(
                    child: Image.asset(
                      'assets/images/ic_not_found.png',
                      height: 200,
                      width: 200,
                    ),
                  )
                : StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    itemCount: homeController.images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Hero(
                          tag: homeController.images[index].id,
                          createRectTween: (begin, end) =>
                              MaterialRectArcTween(begin: begin, end: end),
                          child: Material(
                            child: GestureDetector(
                              onTap: () => Get.to(() => ViewImage(
                                  imageModel: homeController.images[index])),
                              // onLongPress: () => homeController
                              //     .deleteImage(homeController.images[index]),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    period: const Duration(milliseconds: 800),
                                    child: Container(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Obx(() {
                                      var image = homeController.images[index];
                                      return Image.network(
                                        image.imgUrl,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.error),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        StaggeredTile.count(2, index.isEven ? 2 : 3),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
          ),
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
