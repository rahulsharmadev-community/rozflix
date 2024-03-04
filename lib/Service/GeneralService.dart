import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Service {
  final BuildContext context;
  Service({this.context});
  String get app_version => "1.0.06";
  updateVersionChecker() => Center(
        child: Container(
          height: 450,
          child: AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 56),
            actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
            contentPadding: EdgeInsets.all(16),
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
                    .subhead
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(app_version,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subtitle
                      .copyWith(color: Colors.grey)),
            ),
            content: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/gif/rocket.gif",
                  ),
                ),
                Text(
                    "An updated version of the app is available and if you want to use it, you have to update.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .body1
                        .copyWith(color: Colors.black)),
              ],
            ),
            actions: [
              FlatButton(
                  onPressed: () async {
                    String url =
                        "https://play.google.com/store/apps/details?id=com.rahulsharmadev.rozflix";
                    await canLaunch(url)
                        ? await launch(url)
                        : throw 'Could not launch';
                  },
                  child: Text(
                    "Update",
                    style: Theme.of(context).primaryTextTheme.button,
                  ))
            ],
          ),
        ),
      );
  subHeadingTile(String title, Function onTab) => Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).primaryTextTheme.body2),
                IconButton(
                    icon: CircleAvatar(
                        maxRadius: 12,
                        backgroundColor: Colors.blueGrey,
                        child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white)),
                    onPressed: onTab)
              ],
            ),
          ],
        ),
      );
  categoryCards(
          {@required String title1,
          @required String title2,
          @required Color color1,
          @required Color color2,
          @required Function onTap1,
          @required Function onTap2,
          double buttonWidth: null,
          bool is1Active = true,
          bool is2Active = true}) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: RaisedButton(
                onPressed: is1Active ? onTap1 : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: color1,
                child: is1Active
                    ? Text(
                        title1,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .body1
                            .copyWith(color: Colors.white),
                      )
                    : Image.asset(
                        "assets/gif/comingsoontext.gif",
                      ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: RaisedButton(
                onPressed: is2Active ? onTap2 : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: color2,
                child: is2Active
                    ? Text(
                        title2,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .body1
                            .copyWith(color: Colors.white),
                      )
                    : Image.asset(
                        "assets/gif/comingsoontext.gif",
                      ),
              ),
            ),
          ],
        ),
      );
}
