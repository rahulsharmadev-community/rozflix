import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rozflix/MovieData.dart';
import 'package:rozflix/Pages/MovieCollectionPage.dart';
import 'package:rozflix/Service/userdata.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<MovieData> value = favouriteMovie;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(
        Duration(seconds: 1),
        (_) => {
              if (mounted)
                setState(() {
                  value = favouriteMovie;
                }),
            });
    print(UserSaveData.getFavouriteList());
  }

  @override
  Widget build(BuildContext context) {
    return MovieCollectionPage(value, "Favourite Collection");
  }
}
