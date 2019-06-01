import 'dart:ui';

import 'package:flutter/material.dart';

class TitleSize {
  //static final TitleSize _singleton = new TitleSize._internal();
  TextStyle _ts;
  TextStyle _tl;
  TextStyle _tll;

  double _width;

  TitleSize({width}) {
    _width = width;
    //return _singleton;
    _setSize();
  }

  // TitleSize._internal() {
  _setSize() {
    // TextStyle _tsp;
    if (_width < 330.0) {
      _ts = TextStyle(fontSize: 7.6, fontWeight: FontWeight.w700);
      _tl = TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.normal, letterSpacing: -0.5);
      _tll = new TextStyle(color: Colors.white, fontSize: 14.0);
      //  _iconSize = 12.0;
    } else if (_width < 370.0) {
      _ts = TextStyle(fontSize: 9.0, fontWeight: FontWeight.w700);
      _tl = TextStyle(color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.normal, letterSpacing: -0.4);
      _tll = new TextStyle(color: Colors.white, fontSize: 15.0);
      //  _iconSize = 12.0;
    } else if (_width < 390.0) {
      _ts = TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700);
      _tl = TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.normal, letterSpacing: -0.3);
      _tll = new TextStyle(color: Colors.white, fontSize: 16.0);
      //  _iconSize = 12.0;
    } else if (_width < 420.0) {
      _ts = TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700);
      _tl = TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.normal, letterSpacing: -0.1);
      _tll = new TextStyle(color: Colors.white, fontSize: 16.0); //  _iconSize = 13.0;
    } else {
      _ts = TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700);
      _tl = TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.normal, letterSpacing: 0.0);
      _tll = new TextStyle(color: Colors.white, fontSize: 16.0);
      //  _iconSize = 14.0;
    }
  }

  TextStyle get tl => _tl;

  set tl(TextStyle value) {
    _tl = value;
  }

  TextStyle get ts => _ts;

  set ts(TextStyle value) {
    _ts = value;
  }

  double get width => _width;

  set width(double value) {
    _width = value;
  }

  TextStyle get tll => _tll;

  set tll(TextStyle value) {
    _tll = value;
  }
}
