import 'package:flutter/cupertino.dart';
import 'package:rozflix/Service/auth.dart';

class MovieData {
  final String image;
  final String name;
  final String description;
  final String duration;
  final double rating;
  final int releaseyear;
  final String language;
  final bool isLinkActive;
  final String size;
  final List<String> category;
  final String type;
  final List<Map<String, String>> qualityUrl;

  MovieData({
    this.duration,
    @required this.releaseyear,
    this.language,
    this.size,
    this.rating,
    this.isLinkActive,
    @required this.type,
    @required this.name,
    @required this.image,
    @required this.description,
    @required this.category,
    @required this.qualityUrl,
  });
}

List<Map<String, String>> bannerData = [];
List<MovieData> favouriteMovie = [];
List<MovieData> moviedata = [
  // MovieData(
  //     name: 'Jumanji: The Next Level',
  //     releaseyear: 2019,
  //     rating: 6.6,
  //     language: 'Dual Audio (Hindi-English)',
  //     duration: '2h 3min',
  //     favourite: false,
  //     image:
  //         'https://m.media-amazon.com/images/M/MV5BOTVjMmFiMDUtOWQ4My00YzhmLWE3MzEtODM1NDFjMWEwZTRkXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_SX300.jpg',
  //     description:
  //         "In Jumanji: The Next Level, the gang is back but the game has changed. As they return to rescue one of their own, the players will have to brave parts unknown from arid deserts to snowy mountains, to escape the world's most dangerous game.\n\n"
  //         "Director: Jake Kasdan\n"
  //         "Creator: Jake Kasdan, Jeff Pinkner, Scott Rosenberg, Chris Van Allsburg (based on the book \"Jumanji\" by)\n"
  //         "Actors: Dwayne Johnson, Kevin Hart, Jack Black, Karen Gillan",
  //     qualityUrl: [
  //       {
  //         'quality': '480p',
  //         'url':
  //             'https://gdrivepro.xyz/ro.php?id=TWNjK0JpM2hQTG5Qa0x0ZVBCUGJEWXZYeU5SQ3JFMmVrZHh4eGE2a1d6aWpndmJIRVFSUTliWGJ3Wk5RMDQwYlRBUUEzclNwaHMzNG45N245SmpOTTdvenVrVm1GQ1VsanNpSnhReVFiS2JGYkt0NFFEVzZ4RzRNRisreW1Vdkg4ZXhCZlVtekdLV1pDMU9FOFFmaGUzQWRocDA4dHUvTmhyMFg3RUx5Y2RXTU84ZWcvTGhLWFIrQm9KUkdlbTNT'
  //       },
  //       {
  //         'quality': '720p',
  //         'url': 'https://www.videosolo.com/online-video-downloader/'
  //       },
  //       {'quality': '1080p', 'url': 'https://kmhd.link/archives/54284'},
  //     ],
  //     category: [
  //       'Action',
  //       'Adventure',
  //       'Comedy',
  //       'Fantasy'
  //     ]),
];
