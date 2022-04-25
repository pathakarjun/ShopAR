import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_ar/appColors.dart';
import 'package:shop_ar/buttomNavigationPages/profilePage/profileMenu/myAccMenu.dart';
import 'package:shop_ar/screens/loginSignup/login_page.dart';

import 'components/profileMenu.dart';
import 'components/profilePic.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? _firstNameController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            const ProfilePic(),
            Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 40),
                child: buildProfileName()),
            ProfileMenu(
              text: "My Account",
              icon: const Icon(Icons.person_outline, color: AppColors.deep_red),
              press: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyAccount()))
              },
            ),
            ProfileMenu(
              text: "Orders",
              icon: const Icon(Icons.toc_outlined, color: AppColors.deep_red),
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: const Icon(Icons.settings_outlined,
                  color: AppColors.deep_red),
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: const Icon(Icons.help_outline, color: AppColors.deep_red),
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon:
                  const Icon(Icons.logout_outlined, color: AppColors.deep_red),
              press: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    // Replace ForgotPassPage() with home Page Screen
                        (r) => false
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileName() => const Text(
        ("James"),
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      );
}
