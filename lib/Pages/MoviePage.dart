import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rozflix/Service/userdata.dart';
import 'package:url_launcher/url_launcher.dart';
import '../MovieData.dart';
import '../Pages/WebPage.dart';
import '../Service/GeneralService.dart';

class MoviePage extends StatelessWidget {
  final MovieData _movieData;
  MoviePage(this._movieData);
  @override
  Widget build(BuildContext context) {
    Service _service = Service(context: context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(51, 51, 51, 1),
      floatingActionButton: FavouriteButton(_movieData),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.west, color: Colors.white),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_movieData.image),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Image.network(
                    _movieData.image,
                    fit: BoxFit.contain,
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).primaryTextTheme.body1,
                        children: <TextSpan>[
                          TextSpan(
                              text: _movieData.name,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline
                                  .copyWith(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: '  (${_movieData.releaseyear})',
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'PG-13  |  ${_movieData.duration}  ${_movieData.category}',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).primaryTextTheme.body1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 56,
                        ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).primaryTextTheme.headline,
                            children: <TextSpan>[
                              TextSpan(
                                text: _movieData.rating.toString(),
                              ),
                              TextSpan(
                                  text: ' /10\nMetascore: N/A',
                                  style:
                                      Theme.of(context).primaryTextTheme.body1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).primaryTextTheme.body1,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Name: ',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .title
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: _movieData.name,
                        ),
                        TextSpan(
                          text: '\nLanguage: ',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .title
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: _movieData.language,
                        ),
                        TextSpan(
                          text: '\nRelease Year: ',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .title
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: _movieData.releaseyear.toString(),
                        ),
                        TextSpan(
                          text: '\nQuality: ',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .title
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        for (int i = 0; i < _movieData.qualityUrl.length; i++)
                          TextSpan(
                              text: i == _movieData.qualityUrl.length - 1
                                  ? '& ${_movieData.qualityUrl[i]['quality']} '
                                  : '${_movieData.qualityUrl[i]['quality']} '),
                        TextSpan(
                          text: '\nSize: ',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .title
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: _movieData.size != ''
                              ? _movieData.size
                              : 'not define',
                        ),
                        TextSpan(
                          text: '\nFormat: ',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .title
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'MKV or MP4',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Description',
                      style: Theme.of(context).primaryTextTheme.title.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  Text(
                    _movieData.description,
                    style: Theme.of(context).primaryTextTheme.body1,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enjoy Qualitative Content ',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline
                        .copyWith(fontWeight: FontWeight.bold)),
                Icon(Icons.download_rounded, color: Colors.white),
              ],
            ),
            _movieData.isLinkActive
                ? Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(children: [
                      Text('Password : rozflix',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .title
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white60)),
                      _service.categoryCards(
                          title1: _movieData.qualityUrl[0]['quality'],
                          title2: _movieData.qualityUrl[1]['quality'],
                          is1Active:
                              !(_movieData.qualityUrl[0]['url'].length < 2),
                          is2Active:
                              !(_movieData.qualityUrl[1]['url'].length < 2),
                          color1: Colors.blueGrey,
                          color2: Colors.lightGreen,
                          onTap1: () async {
                            String url = _movieData.qualityUrl[0]['url'];
                            if (url.contains("?download=1")) {
                              List<String> initial =
                                  UserSaveData.getDownloadList();
                              if (initial.every(
                                  (element) => element != _movieData.name))
                                initial.add(_movieData.name);
                              UserSaveData.setDownloadList(
                                  setDownloadList: initial);
                              await canLaunch(url)
                                  ? await launch(url)
                                  : throw 'Could not launch';
                            } else
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => WebPage(
                                      name: _movieData.name, url: url)));
                          },
                          onTap2: () async {
                            String url = _movieData.qualityUrl[1]['url'];
                            if (url.contains("?download=1")) {
                              List<String> initial =
                                  UserSaveData.getDownloadList();
                              if (initial.every(
                                  (element) => element != _movieData.name))
                                initial.add(_movieData.name);
                              UserSaveData.setDownloadList(
                                  setDownloadList: initial);
                              await canLaunch(url)
                                  ? await launch(url)
                                  : throw 'Could not launch';
                            } else
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (builder) => WebPage(
                                      name: _movieData.name, url: url)));
                          })
                    ]))
                : Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Image.asset(
                      "assets/gif/comingsoontext.gif",
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class FavouriteButton extends StatefulWidget {
  final MovieData _movieData;
  FavouriteButton(this._movieData);
  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  List<String> fl = UserSaveData.getFavouriteList();
  bool favFinder() {
    bool returnValue = fl.any((element) {
      return element != widget._movieData.name ? false : true;
    });

    print(returnValue);
    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.favorite,
          size: 35,
          color: favFinder() ? Colors.red : Colors.white,
        ),
        onPressed: () {
          setState(() {
            if (!favFinder()) {
              favouriteMovie.add(widget._movieData);
              fl.add(widget._movieData.name);
              UserSaveData.setFavouriteList(setFavouriteList: fl);
            } else {
              favouriteMovie.remove(widget._movieData);
              fl.remove(widget._movieData.name);
              UserSaveData.setFavouriteList(setFavouriteList: fl);
            }
          });
        });
  }
}
