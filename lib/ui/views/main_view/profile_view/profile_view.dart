import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile',
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
