import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'GeneralService.dart';

class UpdatevVersionChecker extends StatefulWidget {
  final Widget returnWidget;
  UpdatevVersionChecker({Key key, @required this.returnWidget});

  @override
  _UpdatevVersionCheckerState createState() => _UpdatevVersionCheckerState();
}

class _UpdatevVersionCheckerState extends State<UpdatevVersionChecker> {
  bool isinternetActive = true;
  String currentVersion;
  Service showMessage;

  void netchecker() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isinternetActive = true;
        });
      }
    } on SocketException catch (error) {
      setState(() {
        isinternetActive = false;
      });
    }
  }

  Widget returnWidget;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      returnWidget = Uextend(widget.returnWidget);
    });
  }

  @override
  Widget build(BuildContext context) {
    showMessage = Service(context: context);
    currentVersion = showMessage.app_version;
    // print(version);
    netchecker();
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: !isinternetActive
            ? Center(
                child: Container(
                  height: 450,
                  child: AlertDialog(
                    backgroundColor: Colors.white54,
                    insetPadding: EdgeInsets.symmetric(horizontal: 56),
                    actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                    title: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: SvgPicture.asset(
                        "assets/svg/Logo.svg",
                        width: 56,
                        height: 56,
                      ),
                      title: Text(
                        "RozFliz",
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline
                            .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(currentVersion),
                    ),
                    content: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            "assets/gif/error.gif",
                          ),
                        ),
                        Text(
                          "Please check your internet connection and try again.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .body2
                              .copyWith(color: Colors.red.shade900),
                        ),
                      ],
                    ),
                    actions: [
                      FlatButton(
                          color: Colors.red,
                          onPressed: () => SystemNavigator.pop(),
                          child: Text(
                            "Exit",
                          ))
                    ],
                  ),
                ),
              )
            : returnWidget);
  }
}

class Uextend extends StatelessWidget {
  final Widget returnWidget;
  Uextend(this.returnWidget);

  @override
  Widget build(BuildContext context) {
    Service showMessage = Service(context: context);
    String currentVersion = showMessage.app_version;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('appVersion').snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          String _version;
          if (snapshot.hasData) {
            Map<String, dynamic> rawVersionData =
                snapshot.data.docs.first.data();
            _version = rawVersionData["version"];
          }

          if (_version != currentVersion && _version != null) {
            return showMessage.updateVersionChecker();
          } else
            return returnWidget;
        });
  }
}
