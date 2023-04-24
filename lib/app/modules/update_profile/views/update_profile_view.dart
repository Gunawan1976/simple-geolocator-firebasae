import 'dart:io';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  Map<String, dynamic> user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print(user);
    controller.NIPcon.text = user["nip"];
    controller.nameC.text = user["name"];
    controller.emailC.text = user["email"];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile Page'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: controller.NIPcon,
            readOnly: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "NIP",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            autocorrect: false,
            controller: controller.nameC,
            decoration: InputDecoration(
              labelText: "Nama",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          TextField(
            autocorrect: false,
            controller: controller.emailC,
            readOnly: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          Text("Photo Profile", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<UpdateProfileController>(
                builder: (c) {
                  if (c.image != null) {
                    return ClipOval(
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Image.file(
                          File(c.image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    if (user["profile"] == null || user["profile"] == "") {
                      return Text("Data kosong");
                    } else {
                      return ClipOval(
                        child: Container(
                          height: 150,
                          width: 150,
                          child: Image.network(
                            user["profile"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              TextButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: Text("Upload"))
            ],
          ),
          SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                controller.updateProfile(user["uid"]);
              },
              child: Text("UPDATE"))
        ],
      ),
    );
  }
}
