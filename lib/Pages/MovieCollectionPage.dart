import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rozflix/MovieData.dart';
import 'package:rozflix/Pages/MoviePage.dart';
import '../Service/FilterService.dart';

class MovieCollectionPage extends StatefulWidget {
  final title;
  final List<MovieData> _moviedata;
  MovieCollectionPage(this._moviedata, this.title);

  @override
  _MovieCollectionPageState createState() => _MovieCollectionPageState();
}

class _MovieCollectionPageState extends State<MovieCollectionPage> {
  String searchName = "";
  List<MovieData> rowData;
  var temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      rowData = widget._moviedata;
    });
  }

  String _iconData = "assets/images/logo/normal.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        actions: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/imdb.svg",
                height: 30,
              ),
              InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: EdgeInsets.only(right: 8.0, left: 8.0),
                    height: 30,
                    child: Image.asset(_iconData),
                  ),
                  onTap: () {
                    setState(() {
                      print(widget._moviedata.first.name);
                      if (_iconData == "assets/images/logo/normal.png") {
                        _iconData = "assets/images/logo/up.png";
                        rowData = FilterService().ratingFilter(rowData);
                      } else if (_iconData == "assets/images/logo/up.png") {
                        {
                          _iconData = "assets/images/logo/down.png";
                          rowData = FilterService()
                              .ratingFilter(rowData, isAccendingtrue: false);
                        }
                      } else if (_iconData == "assets/images/logo/down.png") {
                        {
                          _iconData = "assets/images/logo/normal.png";
                          rowData = widget._moviedata;
                        }
                      }
                    });
                  }),
            ],
          )
        ],
        title: TextField(
            style: Theme.of(context)
                .primaryTextTheme
                .title
                .copyWith(color: Colors.blue.shade200),
            onChanged: (value) {
              setState(() {
                searchName = value;
                print(value);
                rowData =
                    FilterService().searchFilter(widget._moviedata, value);
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white),
              hintText: widget.title,
              hintStyle: Theme.of(context).primaryTextTheme.title,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill)),
        child: rowData.length < 1
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/gif/empty.gif',
                        width: MediaQuery.of(context).size.width * 0.70),
                    Text(
                      'Empty',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline
                          .copyWith(color: Colors.grey.shade300),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            : GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: rowData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (BuildContext ctx, int index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      print(rowData[index].name);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => MoviePage(rowData[index])));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      elevation: 8.0,
                      clipBehavior: Clip.hardEdge,
                      color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(rowData[index].image,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width * 0.30,
                                height:
                                    ((MediaQuery.of(context).size.width / 3 -
                                                6) +
                                            (MediaQuery.of(context).size.width /
                                                    3) *
                                                0.6) -
                                        40),
                          ),
                          Flexible(
                            child: Center(
                              child: Text(
                                rowData[index].name,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(color: Colors.black),
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
    );
  }
}
