import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolokasi/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential userCredential;
  RxBool ishidden = true.obs;

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);
        if (userCredential.user != null &&
            userCredential.user!.emailVerified == true) {
          if (passC.text == "password") {
            Get.offAllNamed(Routes.NEW_PASSWORD);
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        } else {
          print(userCredential);
          Get.snackbar("Kesalahan", "Belum verifikasi akun",
              snackPosition: SnackPosition.BOTTOM);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Kesalahan", "User tidak ditemukan");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Kesalahan", "Passwrod Salah");
        }
      } catch (e) {
        Get.snackbar("Kesalahan", "Tidak bisa login");
      }
    } else {
      Get.snackbar(
          "Terjadi Kesalahan", "Email dan Password tidak boleh kosong");
    }
  }

  void verifikasiUlang() async {
    try {
      await userCredential.user!.sendEmailVerification();
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan",
          "Tidak bisa verifikasi ulang silahkan hubungi admin / CS");
      print(e);
    }
  }
}
