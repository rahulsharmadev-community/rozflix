import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rozflix/Service/auth.dart';
import '../Service/ProfileCardService.dart';

class Profile_GSigin extends StatefulWidget {
  final Widget returnWidget;
  final bool isSignIn;
  Profile_GSigin({this.returnWidget, @required this.isSignIn});
  @override
  _Profile_GSiginState createState() => _Profile_GSiginState();
}

class _Profile_GSiginState extends State<Profile_GSigin> {
  bool isWaiting = false;
  Widget delay(Widget returnWidgt, Duration time) {
    Future.delayed(time, () {
      setState(() {
        isWaiting = true;
      });
    });

    return !isWaiting ? Container() : returnWidgt;
  }

  @override
  Widget build(BuildContext context) {
    final defaultUser = Provider.of<DefaultUser>(context);
    if (defaultUser != null) {
      print("defaultUser.isStart");
      return widget.isSignIn
          ? ProfileCardService(widget.isSignIn)
          : widget.returnWidget;
    } else
      return delay(
          Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                toolbarHeight: kToolbarHeight,
                centerTitle: true,
                title: Image.asset(
                  "assets/images/logo/bannerORG_Smallsize.png",
                  height: 46,
                ),
              ),
              body: Center(
                  child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/moviewbackground.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken))),
                child: ProfileCardService(widget.isSignIn),
              ))),
          Duration(microseconds: 300));
  }
}
