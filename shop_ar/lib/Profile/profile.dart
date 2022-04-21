import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Profile extends StatelessWidget {
  List _items = [
    UserInfo(),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: _items.length,
        itemBuilder: (indexcontext, index) {
          return _items[index];
        });
  }
}

class UserInfo extends StatefulWidget {
  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final double coverHeight = 120;
  final double profileHeight = 120;

  @override
  Widget build(BuildContext context) {
    final bottom = profileHeight / 2 + 5;
    final top = coverHeight - profileHeight / 2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: coverHeight,
              color: const Color(0xffE84855),
              margin: EdgeInsets.only(bottom: bottom),
            ),
            Positioned(top: top, child: buildProfileImage()),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 20), child: buildProfileName()),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: buildEditButton(),
        ),
      ],
    );
  }

  Widget buildProfileImage() => CircleAvatar(
        backgroundColor: Color(0xff1E1E1E),
        radius: profileHeight / 2 + 5,
        child: CircleAvatar(
          radius: profileHeight / 2,
          backgroundColor: Colors.grey.shade800,
          backgroundImage: const AssetImage('assets/bgProfileImg.png'),
        ),
      );

  Widget buildProfileName() => Text(
        'Forest Gump',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      );

  Widget buildEditButton() => ElevatedButton(
        // style: ButtonStyle(
        //     backgroundColor:
        //         MaterialStateProperty.all<Color>(const Color(0xffE84855))),
        onPressed: () {},
        child: Text(
          'Edit Profile',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      );
}
