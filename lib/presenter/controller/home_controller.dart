import 'package:get/get.dart';
import 'package:image_gallery/presenter/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<ImageModel> images = RxList<ImageModel>([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<ImageModel>> getAllImages() =>
      firestore.collection('image').snapshots().map(
        (event) {
          return event.docs.map((e) => ImageModel.fromJson(e.data())).toList();
        },
      );

  @override
  void onInit() {
    images.bindStream(getAllImages());
    super.onInit();
  }
}
