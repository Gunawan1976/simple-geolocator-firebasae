import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.currPass,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Current Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          TextField(
              onChanged: controller.newPassObs,
              autocorrect: false,
              controller: controller.newPass,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
              )),
          SizedBox(height: 15),
          TextField(
            autocorrect: false,
            controller: controller.confNewPass,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirm New Password",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                controller.updatePass();
              },
              child: Text("Change Password"))
        ],
      ),
    );
  }
}
