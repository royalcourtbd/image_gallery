import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery/presenter/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<ImageModel> images = RxList<ImageModel>([]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot? lastDocument; // Store the last document snapshot
  bool isLoadingMore = false;

  @override
  void onInit() {
    images.bindStream(getAllImages());
    // fetchInitialImages();
    super.onInit();
  }

  void fetchInitialImages() async {
    QuerySnapshot snapshot =
        await firestore.collection('image').limit(10).get();
    images.value = snapshot.docs
        .map((e) => ImageModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
  }

  Stream<List<ImageModel>> getAllImages() =>
      firestore.collection('image').limit(10).snapshots().map(
        (event) {
          lastDocument = event.docs.isNotEmpty ? event.docs.last : null;
          return event.docs.map((e) => ImageModel.fromJson(e.data())).toList();
        },
      );

  void fetchMoreImages() async {
    if (isLoadingMore || lastDocument == null) return;
    isLoadingMore = true;
    QuerySnapshot snapshot = await firestore
        .collection('image')
        .startAfterDocument(lastDocument!)
        .limit(10)
        .get();
    if (snapshot.docs.isNotEmpty) {
      images.addAll(snapshot.docs
          .map((e) => ImageModel.fromJson(e.data() as Map<String, dynamic>))
          .toList());
      lastDocument = snapshot.docs.last;
    }
    isLoadingMore = false;
  }

  Future<void> addImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      String fileName = const Uuid().v4();

      try {
        // Upload to Firebase Storage
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref('images/$fileName')
            .putFile(file);

        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Create a new ImageModel
        ImageModel newImage = ImageModel(
          id: fileName,
          imgUrl: downloadUrl,
        );

        // Add to Firestore
        await firestore.collection('image').add(newImage.toJson());

        // // Add the new image to the local list
        // images.insert(0, newImage);

        // Optionally, you can show a success message
        Get.snackbar('Success', 'Image uploaded successfully',
            snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        debugPrint('Error uploading image: $e');
        Get.snackbar('Error', 'Failed to upload image. Please try again.',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<void> deleteImage(ImageModel image) async {
    try {
      // Delete from Firestore
      QuerySnapshot querySnapshot = await firestore
          .collection('image')
          .where('id', isEqualTo: image.id)
          .get();

      for (DocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      // Delete from Firebase Storage
      await FirebaseStorage.instance.ref('images/${image.id}').delete();

      // Remove from local list
      images.remove(image);

      Get.snackbar('Success', 'Image deleted successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      debugPrint('Error deleting image: $e');
      Get.snackbar('Error', 'Failed to delete image. Please try again.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
