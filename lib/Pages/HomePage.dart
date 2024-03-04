import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rozflix/MovieData.dart';
import 'package:rozflix/Pages/CategoryPage.dart';
import 'package:rozflix/Pages/ComngSoon.dart';
import 'package:rozflix/Pages/MovieCollectionPage.dart';
import 'package:rozflix/Pages/MoviePage.dart';
import 'package:rozflix/Pages/profile_GSigin.dart';
import 'package:rozflix/Service/userdata.dart';
import '../Service/FilterService.dart';
import '../Service/GeneralService.dart';

var _screenHeight;
var _screenWidth;
var top;

bool isPad() {
  if (_screenHeight > 768 && _screenWidth > 768)
    return true;
  else
    return false;
}

class TopNameTab extends StatefulWidget {
  @override
  _TopNameTabState createState() => _TopNameTabState();
}

class _TopNameTabState extends State<TopNameTab> {
  String name = UserSaveData.getName(), pic = UserSaveData.getProfilepic();
  @override
  void didChange() {
    setState(() {
      {
        name = UserSaveData.getName();
        pic = UserSaveData.getProfilepic();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 100), () => didChange());
    return ListTile(
      title: Text(
        "Hi ${name}",
        style: Theme.of(context)
            .primaryTextTheme
            .title
            .copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Lets explore your favorite movies',
          style: Theme.of(context).primaryTextTheme.caption),
      trailing: InkResponse(
        onTap: () {
          showDialog(
              context: context,
              builder: (builder) => Profile_GSigin(isSignIn: true));
        },
        child: Image.asset(
          pic,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  List<MovieData> animeList =
      FilterService().categoryFilter(moviedata, "animation");
  List<MovieData> movieList = FilterService().typeFilter(moviedata, "movie");
  List<MovieData> webList = FilterService().typeFilter(moviedata, "web series");

  Widget topBranding() => Column(
        children: [
          Container(
            color: Color.fromRGBO(40, 40, 40, 1),
            height: top,
          ),
          Container(
            width: _screenWidth * 0.35,
            height: kToolbarHeight,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(40, 40, 40, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0))),
            child: Image.asset(
              'assets/images/logo/bannerORG_Smallsize.png',
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    Service _service = Service(context: context);
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;
    top = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: kToolbarHeight),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(child: TopNameTab()),
                    AutoScrollBanner(),
// Trending Category
                    _service.subHeadingTile(
                      "Trending Category",
                      () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => CategoryPage())),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(children: [
                                _service.categoryCards(
                                    title1: 'Fantasy',
                                    color1: Colors.amber,
                                    onTap1: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) => MovieCollectionPage(
                                              FilterService().categoryFilter(
                                                  moviedata, 'Fantasy'),
                                              "Fantasy"),
                                        )),
                                    title2: 'Adventure',
                                    color2: Colors.orange,
                                    onTap2: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) => MovieCollectionPage(
                                              FilterService().categoryFilter(
                                                  moviedata, 'Adventure'),
                                              "Adventure"),
                                        ))),
                                _service.categoryCards(
                                    title1: 'Action',
                                    color1: Colors.red,
                                    onTap1: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) => MovieCollectionPage(
                                              FilterService().categoryFilter(
                                                  moviedata, 'Action'),
                                              "Action"),
                                        )),
                                    title2: 'Sci-Fi',
                                    color2: Colors.blueGrey,
                                    onTap2: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) => MovieCollectionPage(
                                              FilterService().categoryFilter(
                                                  moviedata, 'Sci-Fi'),
                                              "Sci-Fi"),
                                        )))
                              ])),
                        ],
                      ),
                    ),
                    _service.subHeadingTile(
                      "Movies & Web Series",
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>
                              MovieCollectionPage(moviedata, "Search"))),
                    ),
                    for (int i = 0; i < 3 - 1; i++)
                      Container(
                        height: isPad()
                            ? _screenHeight * 0.23
                            : _screenHeight > 650
                                ? _screenHeight * 0.30
                                : _screenHeight * 0.35,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, childAspectRatio: 1.5),
                          itemBuilder: (BuildContext ctx, int index) => Center(
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => MoviePage(
                                          moviedata[index + (i * 10)]))),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8.0)),
                                width: isPad()
                                    ? _screenWidth * 0.20
                                    : _screenWidth > 300
                                        ? _screenWidth * 0.37
                                        : _screenWidth * 0.35,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        moviedata[index + (i * 10)].image,
                                        fit: BoxFit.fill,
                                        height: isPad()
                                            ? _screenHeight * 0.20
                                            : _screenHeight > 650
                                                ? _screenHeight * 0.25
                                                : _screenHeight * 0.30,
                                        width: isPad()
                                            ? double.maxFinite
                                            : _screenWidth > 300
                                                ? _screenWidth * 0.37
                                                : _screenWidth * 0.35,
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          moviedata[index + (i * 10)].name,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .body1
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    _service.subHeadingTile(
                      "Anime",
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => MovieCollectionPage(
                                animeList,
                                "Animation",
                              ))),
                    ),
                    Container(
                      height: isPad()
                          ? _screenHeight * 0.23
                          : _screenHeight > 650
                              ? _screenHeight * 0.30
                              : _screenHeight * 0.35,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 1.5),
                        itemBuilder: (BuildContext ctx, int index) => Center(
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        MoviePage(animeList[index]))),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8.0)),
                              width: isPad()
                                  ? _screenWidth * 0.20
                                  : _screenWidth > 300
                                      ? _screenWidth * 0.37
                                      : _screenWidth * 0.35,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      animeList[index].image,
                                      fit: BoxFit.fill,
                                      height: isPad()
                                          ? _screenHeight * 0.20
                                          : _screenHeight > 650
                                              ? _screenHeight * 0.25
                                              : _screenHeight * 0.30,
                                      width: isPad()
                                          ? double.maxFinite
                                          : _screenWidth > 300
                                              ? _screenWidth * 0.37
                                              : _screenWidth * 0.35,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        animeList[index].name,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .body1
                                            .copyWith(
                                              color: Colors.black,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _service.subHeadingTile(
                      "Latest Movies",
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => MovieCollectionPage(
                                movieList,
                                "Movies",
                              ))),
                    ),
                    for (int i = 0; i < 3 - 1; i++)
                      Container(
                        height: isPad()
                            ? _screenHeight * 0.23
                            : _screenHeight > 650
                                ? _screenHeight * 0.30
                                : _screenHeight * 0.35,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, childAspectRatio: 1.5),
                          itemBuilder: (BuildContext ctx, int index) => Center(
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => MoviePage(
                                          movieList[index + (i * 10)]))),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8.0)),
                                width: isPad()
                                    ? _screenWidth * 0.20
                                    : _screenWidth > 300
                                        ? _screenWidth * 0.37
                                        : _screenWidth * 0.35,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        movieList[index + (i * 10)].image,
                                        fit: BoxFit.fill,
                                        height: isPad()
                                            ? _screenHeight * 0.20
                                            : _screenHeight > 650
                                                ? _screenHeight * 0.25
                                                : _screenHeight * 0.30,
                                        width: isPad()
                                            ? double.maxFinite
                                            : _screenWidth > 300
                                                ? _screenWidth * 0.37
                                                : _screenWidth * 0.35,
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          movieList[index + (i * 10)].name,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .body1
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    _service.subHeadingTile(
                      "Latest Web Series",
                      () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => MovieCollectionPage(
                                webList,
                                "Web Series",
                              ))),
                    ),
                    for (int i = 0; i < 3 - 1; i++)
                      Container(
                        height: isPad()
                            ? _screenHeight * 0.23
                            : _screenHeight > 650
                                ? _screenHeight * 0.30
                                : _screenHeight * 0.35,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, childAspectRatio: 1.5),
                          itemBuilder: (BuildContext ctx, int index) => Center(
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => MoviePage(
                                          webList[index + (i * 10)]))),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8.0)),
                                width: isPad()
                                    ? _screenWidth * 0.20
                                    : _screenWidth > 300
                                        ? _screenWidth * 0.37
                                        : _screenWidth * 0.35,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        webList[index + (i * 10)].image,
                                        fit: BoxFit.fill,
                                        height: isPad()
                                            ? _screenHeight * 0.20
                                            : _screenHeight > 650
                                                ? _screenHeight * 0.25
                                                : _screenHeight * 0.30,
                                        width: isPad()
                                            ? double.maxFinite
                                            : _screenWidth > 300
                                                ? _screenWidth * 0.37
                                                : _screenWidth * 0.35,
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          webList[index + (i * 10)].name,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .body1
                                              .copyWith(
                                                color: Colors.black,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(alignment: Alignment.topCenter, child: topBranding()),
      ],
    );
  }
}

class AutoScrollBanner extends StatefulWidget {
  @override
  _AutoScrollBannerState createState() => _AutoScrollBannerState();
}

class _AutoScrollBannerState extends State<AutoScrollBanner>
    with TickerProviderStateMixin {
  //declare the variables
  AnimationController _animationController;
  Animation<double> _nextPage;
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    //Start at the controller and set the time to switch pages
    _animationController =
        new AnimationController(duration: Duration(seconds: 7), vsync: this);

    _nextPage = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    //Add listener to AnimationController for know when end the count and change to the next page
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset(); //Reset the controller
        final int page =
            bannerData.length - 1; //Number of pages in your PageView
        if (_currentPage < page) {
          _currentPage++;
          _pageController.animateToPage(_currentPage,
              duration: Duration(milliseconds: 500), curve: Curves.easeInSine);
        } else {
          setState(() {
            _currentPage = -1;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return Container(
        width: MediaQuery.of(context).size.width,
        height: isPad() ? 250 : 180,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          onPageChanged: (value) {
            //When page change, start the controller
            _animationController.forward();
          },
          itemCount: bannerData.length,
          itemBuilder: (builder, index) => InkWell(
            onTap: () {
              print(bannerData[index]);
              moviedata.forEach((element) {
                if (element.name == bannerData[index]["name"]) {
                  print("object");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => MoviePage(element)));
                }
              });
              if (moviedata.every(
                      (element) => element.name != bannerData[index]["name"])
                  ? true
                  : false)
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ComingSoon()));
            },
            child: Container(
              height: isPad() ? 250 : 180,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(bannerData[index]["bannerImage"],
                      fit: BoxFit.fill)),
            ),
          ),
        ));
  }
}
