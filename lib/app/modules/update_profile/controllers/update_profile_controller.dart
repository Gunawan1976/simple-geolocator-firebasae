import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolokasi/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController NIPcon = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  final storage = FirebaseStorage.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        print(image!.name);
        print(image!.path);
      } catch (e) {
        print(e);
      }
    } else {
      print(image);
    }
    update();
  }

  Future<void> updateProfile(String uid) async {
    if (nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        NIPcon.text.isNotEmpty) {
      try {
        Map<String, dynamic> data = {
          "name": nameC.text,
        };
        if (image != null) {
          final storageRef = FirebaseStorage.instance.ref();
          File file = File(image!.path);
          String ext = image!.path.split(".").last;
          await storageRef.child("$uid/profile.$ext").putFile(file);
          String urlImage =
              await storageRef.child("$uid/profile.$ext").getDownloadURL();

          data.addAll({"profile": urlImage});
        }
        await firestore.collection("pegawai").doc(uid).update(data);
        Get.back();
        Get.snackbar("Berhasil", "Berhasil melakukan update profile");
      } catch (e) {
        Get.snackbar("Kesalahan", "tidak bisa melakukan update profile");
        print("controller update profile" + e.toString());
      }
    } else {
      Get.snackbar("Kesalahan", "tidak boleh kosong");
    }
  }
}
