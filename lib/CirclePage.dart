import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/CircleProvider.dart';

class Wheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: WheelComponent()),
    );
  }
}

class WheelComponent extends StatefulWidget {
  @override
  _WheelComponentState createState() => _WheelComponentState();
}

class _WheelComponentState extends State<WheelComponent> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    CircleP circleP= Provider.of<CircleP>(context);

    debugPrint("State called");
    debugPrint("Animation controller current position = ${parentController.value}");
    debugPrint("Animation current position ${parentAnimation.value}");

    final double h = MediaQuery.of(context).size.width;
    final double w = MediaQuery.of(context).size.width;

    circleP.setSizes(height: h,width: w);

    return GestureDetector(
      onHorizontalDragEnd: (data){
          debugPrint("forward getting called from = ");
          parentController.forward(from: 0.0);
      },

      child: Transform.scale(
        scale: 1,
        child: Stack(
          children: <Widget>[
            Positioned(
             // bottom: -h/4,
              child: MyRotation(
                angle: parentAnimation,
                child: Container(
                    height: circleP.parentHeight,
                    width: circleP.parentWidth,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: circleP.parentHeight, width: circleP.parentWidth,
                          decoration: BoxDecoration(
                               color: Colors.blue,
                              shape: BoxShape.circle),
                          child: Stack(
                            children: <Widget>[

                              Positioned(
                                  child: MyRotation(
                                      child: MySelector(title: "bottom",),
                                      angle: parentAnimation,
                                      reversed: true,),
                                left: w/2-circleP.childWidth/2,
                                bottom: h/10,
                              ),

                              Positioned(
                                child: MyRotation(
                                  child: MySelector(title: "top",),
                                  angle: parentAnimation,
                                  reversed: true,),
                                left: w/2-circleP.childWidth/2,
                                top: h/10,
                              ),

                              Positioned(
                                child: MyRotation(
                                  child: MySelector(title: "right",),
                                  angle: parentAnimation,
                                  reversed: true,),
                                bottom: w/2-circleP.childHeight/2,
                                left: h/10,
                              ),

                              Positioned(
                                child: MyRotation(
                                  child: MySelector(title: "left",),
                                  angle: parentAnimation,
                                  reversed: true,),
                                bottom: w/2-circleP.childHeight/2,
                                right: h/10,
                              ),

                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimationController parentController;
  Animation parentAnimation;

  @override
  void initState() {
    parentController= AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOutCubic,
      parent: parentController,
    );

    parentAnimation= Tween(
        begin: 0.0,
        end: pi).animate(curvedAnimation)
    ..addListener((){
      setState(() {
      });
    })
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
        } else if (state == AnimationStatus.dismissed) {
          print("dismissed");
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    parentController.dispose();
    super.dispose();
  }
}

class MyRotation extends StatelessWidget {
  MyRotation({
    this.reversed,
    @required this.angle,
    @required this.child,
  });

  final Widget child;
  final Animation<double> angle;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: angle,
      // This child will be pre-built by the AnimatedBuilder for performance optimizations
      // since it won't be rebuilt on every "animation tick".
      child: child,
      builder: (context, child) {
        debugPrint("angle = ${angle.value}");

        if(reversed??false){
          return Transform.rotate(
              angle: -angle.value,
              child: child,);
        }else {
          return Transform.rotate(
            angle: angle.value,
            child: child,
          );
        }
      },
    );
  }
}

class MySelector extends StatelessWidget {
  final String title;
  MySelector({this.title});
  @override
  Widget build(BuildContext context) {
    CircleP circleP= Provider.of<CircleP>(context);
    final double cw=circleP.childWidth;
    final double ch=circleP.childHeight;
    return Container(
      child: Center(child: Text(title??"Main")),
      height: ch,
      width: cw,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
    );
  }
}
