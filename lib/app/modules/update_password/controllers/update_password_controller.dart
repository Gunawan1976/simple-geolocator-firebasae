import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  RxString newPassObs = ''.obs;
  RxString confPassObs = ''.obs;
  TextEditingController currPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confNewPass = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void updatePass() async {
    if (currPass.text.isNotEmpty &&
        newPass.text.isNotEmpty &&
        confNewPass.text.isNotEmpty) {
      if (newPass.text == confNewPass.text) {
        try {
          String emailUser = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currPass.text);

          await auth.currentUser!.updatePassword(newPass.text);
          Get.back();
          Get.snackbar("Berhsail", "Mengganti password");
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar("Kesalahan", "Current password salah");
          } else {
            Get.snackbar("Kesalahan", "${e.code.toLowerCase()}");
          }
        } catch (e) {
          Get.snackbar("Kesalahan", "tidak bisa update password");
        }
      } else {
        Get.snackbar("Kesalahan", "Password Tidak Cocok");
      }
    } else {
      Get.snackbar("Kesalahan", "Wajib diisi");
    }
  }
}
