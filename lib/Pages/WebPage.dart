import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rozflix/Service/userdata.dart';
import 'package:url_launcher/url_launcher.dart';

class WebPage extends StatelessWidget {
  final String name, url;
  WebPage({@required this.name, @required this.url});
  int progress;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: const Text('Processing...'),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: Uri.parse(url)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(useOnDownloadStart: true),
            ),

            onDownloadStart: (controller, url) async {
              List<String> initial = UserSaveData.getDownloadList();
              if (initial.every((element) => element != name))
                initial.add(name);
              UserSaveData.setDownloadList(setDownloadList: initial);
              Navigator.of(context).pop();
              await canLaunch(url.toString())
                  ? await launch(url.toString())
                  : throw 'Could not launch';
            },
            // contextMenu: contextMenu,
            onWebViewCreated: (InAppWebViewController controller) {
              webViewController = controller;
            },
          )),
        ]));
  }
}
