// Created By JLA 2019/10/29/time:03:29

import 'package:flutter/material.dart';
import 'package:playground_wheel_nav/Provider/CircleProvider.dart';
import 'package:provider/provider.dart';

class MyElement extends StatefulWidget {
  final String title;
  MyElement({this.title});



  @override
  MyElementState createState() => MyElementState();

}

class MyElementState extends State<MyElement> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {

    CircleP circleP = Provider.of<CircleP>(context);

    final double w = circleP.childWidth;
    final double h = circleP.childHeight;

    return RotationTransition(
      turns: Tween(begin: 0.0, end: 0.0).animate(childController),
      child: RotationTransition(
        turns: childAnimation,
        child: Container(
          child: Center(child: Text(widget.title ?? "title")),
          height: h,
          width: w,
          decoration: BoxDecoration(
            color: Colors.red,
          ),
        ),
      ),
    );

  }




  AnimationController childController;
  Animation childAnimation;

  @override
  void dispose() {
    childController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    childController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
      upperBound: 1,
    );

    childAnimation = Tween(begin: 0.00, end: 0.04)
        .animate(childController);

    super.initState();
  }
}


