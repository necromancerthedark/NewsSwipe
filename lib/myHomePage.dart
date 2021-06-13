import 'package:flutter/material.dart';
import 'package:swipeable/MySwipeCard.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MySwipeCard(),
    );
  }
}
