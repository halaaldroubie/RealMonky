import 'package:flutter/material.dart';

class OffersView extends StatefulWidget {
  OffersView({Key? key}) : super(key: key);

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Offers',
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
