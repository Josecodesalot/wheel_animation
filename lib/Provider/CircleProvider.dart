// Created By JLA 2019/10/29/time:00:51

import 'package:flutter/material.dart';

class CircleP extends ChangeNotifier{
 double parentHeight, parentWidth, childHeight, childWidth;


 setSizes({double height, double width}){

  parentHeight =height;
  parentWidth=width;

  childHeight = height/10;
  childWidth = width/10+50;

 }
}