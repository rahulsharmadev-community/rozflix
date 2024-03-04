import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rozflix/MovieData.dart';
import 'package:rozflix/Pages/WebPage.dart';
import 'package:rozflix/Service/userdata.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Service/GeneralService.dart';

class DownloadPage extends StatefulWidget {
  get platform => null;

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  emailService(String id, String subject, String body) async {
    try {
      await launch(Uri(scheme: 'mailto', path: id, queryParameters: {
        'subject': subject.replaceAll(" ", "\t"),
        'body': body.replaceAll(" ", "\t")
      }).toString());
    } catch (e) {
      showDialog(
          context: context,
          builder: (builder) => AlertDialog(
                title: Text("Something Wrong"),
                content: Text(
                    "Currently error is not understood. Your response is important for us please wait and try again later."),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Service _service = Service(context: context);
    return new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.help),
                onPressed: () => showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text("User Safety"),
                          content: Text(
                            "Due to safety of user privacy file will downloaded with user default browser or selected browser.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .body1
                                .copyWith(color: Colors.black),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Ok"))
                          ],
                        )))
          ],
          title: new Text(
            "Download History",
            style: Theme.of(context)
                .primaryTextTheme
                .subhead
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill)),
            child: UserSaveData.getDownloadList().length < 1
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/gif/empty.gif',
                            width: MediaQuery.of(context).size.width * 0.70),
                        Text(
                          'No Data Inventory',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline
                              .copyWith(color: Colors.grey.shade300),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 56,
                        ),
                        Text(
                          "Due to safety of user privacy\nfile will downloaded with user\ndefault browser or selected browser.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .body1
                              .copyWith(color: Colors.white60),
                        ),
                      ],
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.vertical,
                    children: List.generate(
                        UserSaveData.getDownloadList().length,
                        (i) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              child: Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                child: new ListTile(
                                  tileColor: Theme.of(context)
                                      .backgroundColor
                                      .withOpacity(0.5),
                                  trailing: Image.asset(
                                    "assets/gif/left_swipe.gif",
                                  ),
                                  leading: new Icon(
                                      Icons.download_done_outlined,
                                      color: Colors.green),
                                  title: new Text(
                                    UserSaveData.getDownloadList()[i],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .title
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                actions: <Widget>[
                                  new IconSlideAction(
                                    caption: 'Feedback',
                                    color: Colors.blue.withOpacity(0.3),
                                    icon: Icons.feedback,
                                    onTap: () => emailService(
                                        'noreply.rozflix@gmail.com',
                                        "Feedback by ${UserSaveData.getName()}",
                                        "Dear RozFlix Team\n"),
                                  ),
                                  new IconSlideAction(
                                      caption: 'Report',
                                      color: Colors.indigo.withOpacity(0.3),
                                      icon: Icons.link_off,
                                      onTap: () => emailService(
                                          'noreply.rozflix@gmail.com',
                                          "Report by ${UserSaveData.getName()}",
                                          "Movie Id: ${UserSaveData.getDownloadList()[i]}\n\nDear RozFlix Team\n")),
                                ],
                                secondaryActions: <Widget>[
                                  new IconSlideAction(
                                      caption: 'Retry',
                                      color: Colors.green.withOpacity(0.3),
                                      icon: Icons.replay,
                                      onTap: () {
                                        MovieData _movieData;

                                        setState(() {
                                          if (moviedata.any((element) {
                                            if (element.name ==
                                                UserSaveData.getDownloadList()[
                                                    i]) {
                                              _movieData = element;
                                            }
                                            return element.name ==
                                                UserSaveData.getDownloadList()[
                                                    i];
                                          })) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (builder) => AlertDialog(
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                child: Text(
                                                                    "Cancel"))
                                                          ],
                                                          title: Text(
                                                              "Choose quality"),
                                                          content: Container(
                                                            height: 100,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                    'Password : rozflix',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .primaryTextTheme
                                                                        .title
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.black54)),
                                                                _service
                                                                    .categoryCards(
                                                                        title1: _movieData.qualityUrl[0][
                                                                            'quality'],
                                                                        title2: _movieData.qualityUrl[1]
                                                                            [
                                                                            'quality'],
                                                                        is1Active: !(_movieData.qualityUrl[0]['url'].length <
                                                                            2),
                                                                        is2Active:
                                                                            !(_movieData.qualityUrl[1]['url'].length <
                                                                                2),
                                                                        color1: Colors
                                                                            .blueGrey,
                                                                        color2: Colors
                                                                            .lightGreen,
                                                                        onTap1:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pushReplacement(MaterialPageRoute(builder: (builder) => WebPage(name: _movieData.name, url: _movieData.qualityUrl[0]['url'])));
                                                                        },
                                                                        onTap2:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pushReplacement(MaterialPageRoute(builder: (builder) => WebPage(name: _movieData.name, url: _movieData.qualityUrl[1]['url'])));
                                                                        })
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                          }
                                        });
                                      }),
                                  new IconSlideAction(
                                      caption: 'Delete',
                                      color: Colors.red.withOpacity(0.3),
                                      icon: Icons.delete,
                                      onTap: () => setState(() {
                                            List<String> initial =
                                                UserSaveData.getDownloadList();

                                            initial.removeAt(i);
                                            UserSaveData.setDownloadList(
                                                setDownloadList: initial);
                                            setState(() {});
                                          })),
                                ],
                              ),
                            )))));
  }

  _showSnackBar(String content) => SnackBar(content: Text(content));
}
