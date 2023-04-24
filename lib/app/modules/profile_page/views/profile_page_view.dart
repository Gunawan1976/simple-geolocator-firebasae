import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolokasi/app/controllers/home_index_controller.dart';
import 'package:geolokasi/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  final pageC = Get.find<HomeIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snap) {
            if (snap.hasData) {
              Map<String, dynamic> user = snap.data!.data()!;
              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            user["profile"] != null && user["profile"] != ""
                                ? user["profile"]
                                : "https://ui-avatars.com/api/?name=${user['name']}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    user["name"].toString().toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    user["email"].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 15),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.UPDATE_PROFILE, arguments: user);
                    },
                    leading: Icon(Icons.person),
                    title: Text("Update Profile"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.UPDATE_PASSWORD);
                    },
                    leading: Icon(Icons.vpn_key),
                    title: Text("Change Password"),
                  ),
                  user["role"] == "admin"
                      ? ListTile(
                          onTap: () {
                            Get.toNamed(Routes.ADD_PEGAWAI);
                          },
                          leading: Icon(Icons.person_add_alt_1),
                          title: Text("Tambah Pegawai"),
                        )
                      : SizedBox(),
                  ListTile(
                    onTap: () async {
                      controller.logout();
                    },
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                  )
                ],
              );
            }
            return SizedBox();
          },
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.react,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.fingerprint, title: 'Add'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: pageC.pageIndex.value,
          onTap: (int i) => pageC.changePage(i),
        ));
  }
}
