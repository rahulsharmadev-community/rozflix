import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("We'r Sorry"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/gif/monkey.gif",
                ),
                Text(
                  "We're working very hard for you.\nPlease be patience Data will be available soon.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.title,
                ),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(vertical: 32.0),
          child: Image.asset(
            "assets/gif/comingsoontext.gif",
          ),
        ),
      ]),
    );
  }
}
