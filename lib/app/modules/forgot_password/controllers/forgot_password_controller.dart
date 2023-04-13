import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailC = TextEditingController();

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.snackbar("Berhasil", "Email lupa password sudah di kirim");
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
      Get.snackbar("Terjadi Kesalahan", "Email tidak boleh kosong");
    }
  }
}
