import 'package:flutter/material.dart';
import 'package:geolokasi/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  autocorrect: false,
                  controller: controller.emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  autocorrect: false,
                  controller: controller.passC,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          controller.login();
                        },
                        child: Text("Login"))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.FORGOT_PASSWORD);
                        },
                        child: Text("Lupa Password")),
                    Text("|"),
                    TextButton(
                        onPressed: () {
                          controller.verifikasiUlang();
                          Get.snackbar("Keterangan", "Berhasil");
                        },
                        child: Text(
                          "Verifikasi ulang akun",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
