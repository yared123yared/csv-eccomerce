import 'package:flutter/material.dart';

class LoginSize extends StatelessWidget {
  late Size _screenSize;
  late double _height;
  late double _width;
  late double _fontSize1;
  late double _welcomeHeight;
  late double _welcomeWidth;
  late double _textFieldWidth;
  late double _textFieldHeight;
  late double _loginButtonHeight;
  late double _loginButtonWidth;
  late double _fontSize2;

  Size get getscreenSize {
    return this._screenSize;
  }

  double get getHeight {
    return this._height;
  }

  double get getWidth {
    return this._width;
  }

  double get getFontSize1 {
    return this._fontSize1;
  }

  double get getWelcomeHeight {
    return this._welcomeHeight;
  }

  double get getWelcomeWidth {
    return this._welcomeWidth;
  }

  double get getTextFieldWidth {
    return this._textFieldWidth;
  }

  double get getTextFieldHeight {
    return this._textFieldHeight;
  }

  double get getLoginButtonWidth {
    return this._loginButtonWidth;
  }

  double get getLoginButtonHeight {
    return this._loginButtonHeight;
  }

  double get getFontSize2 {
    return this._fontSize2;
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._height = this._screenSize.height;
    this._width = _screenSize.width;
    this._fontSize1 = _height * 0.04;
    this._welcomeHeight = this._height * 0.25;
    this._welcomeWidth = this._width * 0.65;
    this._textFieldWidth = this._width * 0.9;
    this._loginButtonHeight = this._height * 0.06;
    this._loginButtonWidth = this._width * 0.9;
    this._fontSize2 = this._height * 0.025;

    return Container();
  }
}
