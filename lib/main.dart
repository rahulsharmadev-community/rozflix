import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozflix/MovieData.dart';
import 'package:rozflix/Pages/DownloadPage.dart';
import 'package:rozflix/Pages/FavouritePage.dart';
import 'package:rozflix/Pages/HomePage.dart';
import 'package:rozflix/Pages/profile_GSigin.dart';
import 'package:rozflix/Service/RestartWidget.dart';
import "Service/userdata.dart";
import 'package:rozflix/Service/ThemeCollection.dart';
import 'package:provider/provider.dart';
import 'package:rozflix/Service/UpdatevVersionChecker.dart';
import 'Service/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  await UserSaveData.init();
  runApp(RestartWidget(child: PreRefresh()));
}

class PreRefresh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("object again");
    return StreamProvider<DefaultUser>.value(
        value: AuthService().user,
        initialData: null,
        child: LayoutBuilder(builder: (context, constraints) {
          ThemeCollection _theme =
              ThemeCollection(constraints.maxHeight, constraints.maxWidth);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: _theme.darkTheme,
              home: FutureBuilder(
                  // Replace the 6 second delay with your initialization code:
                  future: Future.delayed(Duration(seconds: 6)),
                  builder: (context, AsyncSnapshot snapshot) {
                    // Show splash screen while waiting for app resources to load:
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Scaffold(
                        backgroundColor: Theme.of(context).backgroundColor,
                        body: Center(
                          child: Image.asset(
                              "assets/gif/SplashScreen-Once_ORG_smallsize.gif",
                              width: MediaQuery.of(context).size.width * 0.60),
                        ),
                      );
                    else
                      // Loading is done, return the app:
                      return UpdatevVersionChecker(
                        returnWidget: Profile_GSigin(
                          returnWidget: MyApp(),
                          isSignIn: false,
                        ),
                      );
                  }));
        }));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('movieData').snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<MovieData> _movieData = [];
          if (snapshot.hasData) {
            var lenght = snapshot.data.size;
            List<String> doc = snapshot.data.docs.map((e) {
              return e.id;
            }).toList();

            List<dynamic> _slotData = [];
            List<dynamic> _bannerRowData = [];
            List<Map<String, String>> _bannerData = [];
            snapshot.data.docs.forEach((e) {
              if (e.id != "Banner")
                _slotData.add(e.data());
              else {
                _bannerRowData.add(e.data());
              }
            });
            var btemp = _bannerRowData.map((e) => e["bannerData"]).first;
            btemp.forEach((data) {
              _bannerData.add(
                  {"name": data["name"], "bannerImage": data["bannerImage"]});
            });
            List<dynamic> listData = [];
            _slotData.forEach((element) {
              element["List"].forEach((value) {
                listData.add(value);
              });
            });
            listData.forEach((element) {
              List<String> categoryTemp = [];
              List<Map<String, String>> qualityUrlTemp = [];
              element['category']
                  .forEach((temp) => categoryTemp.add(temp.toString()));

              for (int i = 0; i < element['quality'].length; i++) {
                qualityUrlTemp.add({
                  'quality': element['quality'][i],
                  'url': element['url'][i]
                });
              }
              return _movieData.add(MovieData(
                releaseyear: element['releaseyear'],
                name: element['name'].toString(),
                image: element['image'].toString(),
                description: element['description'],
                rating: element['rating'].toDouble(),
                duration: element['duration'],
                size: element['size'],
                type: element["type"],
                language: element['language'],
                isLinkActive: element["isLinkActive"],
                category: categoryTemp,
                qualityUrl: qualityUrlTemp,
              ));
            });
            moviedata = _movieData;
            bannerData = _bannerData;
            return PageNavigator();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PageNavigator extends StatefulWidget {
  @override
  _PageNavigatorState createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  int currentPage = 1;

  Widget bottomIconsCard(int serialNo, String icons) => SvgPicture.asset(
        icons,
        fit: BoxFit.fill,
        height:
            serialNo != currentPage ? kToolbarHeight / 2 : kToolbarHeight / 1.5,
        width:
            serialNo != currentPage ? kToolbarHeight / 2 : kToolbarHeight / 1.5,
      );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if (favouriteMovie.length == 0)
        moviedata.forEach((globle) {
          UserSaveData.getFavouriteList().forEach((local) {
            if (globle.name == local) {
              favouriteMovie.add(globle);
            }
          });
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          letIndexChange: (value) => true,
          height: kToolbarHeight,
          buttonBackgroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInExpo,
          index: currentPage,
          color: Theme.of(context).primaryColor,
          animationDuration: Duration(milliseconds: 300),
          items: <Widget>[
            bottomIconsCard(0, 'assets/svg/heart.svg'),
            bottomIconsCard(1, 'assets/svg/Logo.svg'),
            bottomIconsCard(2, 'assets/svg/cloud-download.svg'),
          ],
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
        ),
        body: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill)),
            child: currentPage == 0
                ? FavouritePage()
                : currentPage == 1
                    ? HomePage()
                    : DownloadPage()));
  }
}
