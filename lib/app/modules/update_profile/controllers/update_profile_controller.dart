import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolokasi/app/routes/app_pages.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController NIPcon = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateProfile(String uid) async {
    if (nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        NIPcon.text.isNotEmpty) {
      try {
        firestore.collection("pegawai").doc(uid).update({"name": nameC.text});
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
