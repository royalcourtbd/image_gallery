import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery/presenter/controller/home_controller.dart';
import 'package:image_gallery/presenter/ui/privacy_policy.dart';
import 'package:image_gallery/presenter/ui/view_image.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log(homeController.images.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
        centerTitle: true,
        backgroundColor: Color(0xffF4C2C2),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffF4C2C2),
              ),
              child: Center(
                child: Image.asset('assets/images/splash_icon.png'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.policy),
              title: Text('Privacy Policy'),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Obx(
          () => StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: homeController.images.length,
            itemBuilder: (BuildContext context, int index) => ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Hero(
                tag: homeController.images[index].id,
                createRectTween: (begin, end) =>
                    MaterialRectArcTween(begin: begin, end: end),
                child: Material(
                  child: InkWell(
                    onTap: () => Get.to(() =>
                        ViewImage(imageModel: homeController.images[index])),
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
                ),
              ),
            ),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(2, index.isEven ? 2 : 3),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
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
