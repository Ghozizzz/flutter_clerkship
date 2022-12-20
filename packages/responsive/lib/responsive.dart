import 'package:flutter/widgets.dart';

extension ResponsiveInt on int {
  double get w => Responsive.w(this.toDouble());
  double get h => Responsive.h(this.toDouble());
  double get wp => Responsive.wp(this.toDouble());
  double get hp => Responsive.hp(this.toDouble());
}

extension ResponsiveDouble on double {
  double get w => Responsive.w(this.toDouble());
  double get h => Responsive.h(this.toDouble());
  double get wp => Responsive.wp(this.toDouble());
  double get hp => Responsive.hp(this.toDouble());
}

class Responsive {
  static double _originScreenWidth = 375;
  static double _originScreenHeight = 812;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _blockSize;
  static late double _blockSizeVertical;
  late BuildContext context;

  static void setDesignSize(double width, double height) {
    _originScreenWidth = width;
    _originScreenHeight = height;
  }

  static void initScreenSize(BuildContext context) {
    if (MediaQuery.of(context).size.height /
            MediaQuery.of(context).size.width >=
        1.77777778) {
      _originScreenWidth = 360.0;
      _originScreenHeight = 640.0;
    }
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _blockSize = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;
  }

  static double h(double height) {
    var calculation = (height / _originScreenHeight) * 100;
    return calculation * _blockSizeVertical;
  }

  static double w(double width) {
    var calculation = (width / _originScreenWidth) * 100;
    return calculation * _blockSize;
  }

  static double wp(double width) {
    return _screenWidth * (width / 100.0);
  }

  static double hp(double height) {
    return _screenHeight * (height / 100.0);
  }
}
