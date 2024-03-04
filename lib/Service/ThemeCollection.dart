import 'package:flutter/material.dart';

class ThemeCollection {
  final height, width;

  ThemeCollection(this.height, this.width);

  ThemeData get darkTheme {
    DefaultFont _defaultfont = DefaultFont(height, width);
    return ThemeData(
        primaryColor: Color.fromRGBO(40, 40, 40, 1),
        backgroundColor: Color.fromRGBO(40, 40, 40, 1),
        iconTheme: IconThemeData(color: Colors.white),
        primaryTextTheme: TextTheme(
            button: _defaultfont
                .normal(color: Colors.blue)
                .copyWith(fontWeight: FontWeight.bold),
            body1: _defaultfont.normal(),
            body2: _defaultfont
                .normal()
                .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
            title: _defaultfont.titleXL(),
            headline: _defaultfont.titleXXL(),
            display1: _defaultfont.titleXXXL(),
            subtitle: _defaultfont.small(),
            subhead: _defaultfont.apptitle()),
        pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder()
            }));
  }
}

class DefaultFont {
  double _localscreenHeight;
  double _localscreenWight;
  final String _fontFamily;
  DefaultFont(this._localscreenHeight, this._localscreenWight,
      [this._fontFamily]);
  double _checkDevice({@required double iPhone, @required double ipad}) {
    if (_localscreenHeight > 768 && _localscreenWight > 768)
      return ipad;
    else
      return iPhone;
  }

  TextStyle small({Color color = Colors.white}) => TextStyle(
      fontSize: _checkDevice(
        iPhone: 12,
        ipad: 22,
      ),
      fontWeight: FontWeight.normal,
      color: color);

  TextStyle normal({Color color = Colors.white}) => TextStyle(
      fontSize: _checkDevice(iPhone: 14, ipad: 18),
      fontWeight: FontWeight.normal,
      color: color);

  TextStyle titleXL({Color color = Colors.white}) => TextStyle(
      fontSize: _checkDevice(iPhone: 18, ipad: 24),
      fontWeight: FontWeight.normal,
      color: color);

  TextStyle titleXXL({Color color = Colors.white}) => TextStyle(
      fontSize: _checkDevice(iPhone: 22, ipad: 28),
      fontWeight: FontWeight.normal,
      color: color);

  TextStyle titleXXXL({Color color = Colors.white}) => TextStyle(
      fontSize: _checkDevice(iPhone: 28, ipad: 32),
      fontWeight: FontWeight.normal,
      color: color);

  TextStyle titleMAX({Color color = Colors.white}) => TextStyle(
      fontSize: _checkDevice(iPhone: 34, ipad: 38),
      fontWeight: FontWeight.normal,
      color: color);

  TextStyle apptitle({Color color = Colors.white}) => TextStyle(
      fontSize: _checkDevice(iPhone: 20, ipad: 28),
      fontWeight: FontWeight.normal,
      color: color);

  TextStyle titleSuperMax({Color color = Colors.white}) => TextStyle(
      fontSize: _checkDevice(iPhone: 34, ipad: 54),
      fontWeight: FontWeight.normal,
      color: color);
}
