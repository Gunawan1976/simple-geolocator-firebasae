import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolokasi/app/routes/app_pages.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  TextEditingController newpassC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  void updatePassword() async {
    if (newpassC.text.isNotEmpty && newpassC.text != "password") {
      try {
        await auth.currentUser!.updatePassword(newpassC.text);
        String email = auth.currentUser!.email!;
        await auth.signOut();
        await auth.signInWithEmailAndPassword(
            email: email, password: newpassC.text);
        Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Kesalahan", "Password harus lebih dari 6 suku kata");
        }
      } catch (e) {}
    } else if (newpassC.text == "password") {
      Get.snackbar("Kesalahan", "Password tidak boleh sama");
    } else if (newpassC.text.length <= 6) {
      Get.snackbar("Kesalahan", "Password harus lebih dari 6 suku kata");
    } else {
      Get.snackbar("Kesalahan", "Password wajib diisi");
    }
  }
}
