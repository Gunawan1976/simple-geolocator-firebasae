import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPegawaiController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController NIPcon = TextEditingController();
  TextEditingController passAdminC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> prosesAddPegawai() async {
    if (passAdminC.text.isNotEmpty) {
      try {
        String emailAdmin = auth.currentUser!.email!;
        UserCredential userAdminCredential =
            await auth.signInWithEmailAndPassword(
                email: emailAdmin, password: passAdminC.text);
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: "password");
        //print(userCredential);
        if (userCredential != null) {
          String uid = userCredential!.user!.uid;

          firestore.collection("pegawai").doc(uid).set({
            "nip": NIPcon.text,
            "name": nameC.text,
            "email": emailC.text,
            "uid": uid,
            "createAt": DateTime.now().toIso8601String(),
          });

          await userCredential.user!.sendEmailVerification();

          await auth.signOut();

          UserCredential userAdminCredential =
              await auth.signInWithEmailAndPassword(
                  email: emailAdmin, password: passAdminC.text);

          Get.back();
          Get.back();
          Get.snackbar("Berhasil", "sukses menambah pegawai");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Kesalahan", "password terlalu lemah kek kamu");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Kesalahan", "pegawai sudah ada");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Kesalahan", "password salah bang");
        } else {
          Get.snackbar("Kesalahan", "tidak dapat login");
        }
      } catch (e) {
        print(e);
      }
    } else {
      Get.snackbar("Kesalahan", "password wajib diisi");
    }
  }

  void addPegawai() async {
    if (nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        NIPcon.text.isNotEmpty) {
      Get.defaultDialog(
          title: "Validasi admin",
          content: Column(
            children: [
              TextField(
                controller: passAdminC,
                autocorrect: false,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password", border: OutlineInputBorder()),
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await prosesAddPegawai();
              },
              child: Text("Add Pegawai"),
            )
          ]);
    } else {
      Get.snackbar("Kesalahan", "tidak boleh kosong");
    }
  }
}
