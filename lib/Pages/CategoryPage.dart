import 'package:flutter/material.dart';
import 'package:rozflix/MovieData.dart';
import 'package:rozflix/Service/FilterService.dart';
import 'package:rozflix/Pages/MovieCollectionPage.dart';

class CategoryPage extends StatelessWidget {
  List<Map<String, String>> _categorylist = [
    {'type': 'Fantasy', 'image': 'assets/images/poster/fantacy.jpg'},
    {'type': 'Adventure', 'image': 'assets/images/poster/adventure.jpg'},
    {'type': 'Action', 'image': 'assets/images/poster/action.jpg'},
    {'type': 'Sci-Fi', 'image': 'assets/images/poster/sci.jpg'},
    {'type': 'Crime', 'image': 'assets/images/poster/crime.jpg'},
    {'type': 'Romance', 'image': 'assets/images/poster/romance.jpg'},
    {'type': 'Comedy', 'image': 'assets/images/poster/comady.jpg'},
    {'type': 'Drama', 'image': 'assets/images/poster/drama.jpg'},
    {'type': 'Biography', 'image': 'assets/images/poster/Biography.jpg'},
    {'type': 'Animation', 'image': 'assets/images/poster/anim.jpg'},
    {'type': 'Horror', 'image': 'assets/images/poster/Horror.jpg'},
    {'type': 'History', 'image': 'assets/images/poster/history.jpg'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: _categorylist.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => MovieCollectionPage(
                FilterService().categoryFilter(
                  moviedata,
                  _categorylist[index]['type'],
                ),
                _categorylist[index]['type']),
          )),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                    image: AssetImage(_categorylist[index]['image'])),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 5))
                ]),
            alignment: Alignment.center,
            child: Text(
              _categorylist[index]['type'],
              style: Theme.of(context).primaryTextTheme.display1.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                        // bottomLeft
                        blurRadius: 5,
                        offset: Offset(-1, -1),
                        color: Colors.black),
                    Shadow(
                        // bottomRight
                        blurRadius: 5,
                        offset: Offset(1, -1),
                        color: Colors.black),
                    Shadow(
                        // topRight
                        blurRadius: 5,
                        offset: Offset(1, 1),
                        color: Colors.black),
                    Shadow(
                        // topLeft
                        blurRadius: 5,
                        offset: Offset(-1, 1),
                        color: Colors.black)
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
