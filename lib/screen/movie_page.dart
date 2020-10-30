import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/services/movie_pre_text.dart';
import 'package:movie_app/services/image_card.dart';
import 'package:movie_app/services/tab_bar_contents.dart';
import 'search.dart';
import 'package:movie_app/screen/description.dart';

List<int> comingSoonMoviesID = [];
List<String> comingSoonMovies = [];

class MoviePage extends StatefulWidget {
  MoviePage(
      {this.movieData,
      this.allGenreName,
      this.trendingMovies,
      this.upcomingMovieID,
      this.movieList,
      this.trendingMoviesTitle,
      this.trendingMovieID});

  final movieData;
  final allGenreName;
  final trendingMovies;
  final trendingMoviesTitle;
  final upcomingMovieID;
  final movieList;
  final trendingMovieID;

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<String> allMovieGenre = [];
  List<String> trendingMovies = [];
  List<String> trendingMoviesTitle = [];
  List<int> trendingMovieID = [];
  List<String> movieList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComingSoonMovies(widget.movieData);
    getAllGenres(widget.allGenreName);
    getTrendingMovies(widget.trendingMovies);
    getTrendingMoviesTitle(widget.trendingMoviesTitle);
    getComingSoonMoviesID(widget.upcomingMovieID);
    getMovieList(widget.movieList);
    getTrendingMovieID(widget.trendingMovieID);
  }

  void getComingSoonMovies(movieData) {
    setState(() {
      if (movieData == null) {
        comingSoonMovies = [];
        return;
      }
      comingSoonMovies = movieData;
    });
  }

  void getMovieList(movieList) {
    setState(() {
      if (movieList == null) {
        movieList = [];
        return;
      }
      movieList = movieList;
    });
  }

  void getAllGenres(genreName) {
    setState(() {
      if (genreName == null) {
        allMovieGenre = [];
        return;
      }
      allMovieGenre = genreName;
    });
  }

  void getTrendingMovies(trending) {
    setState(() {
      if (trending == null) {
        trendingMovies = [];
        return;
      }
      trendingMovies = trending;
    });
  }

  void getTrendingMoviesTitle(trendingTitle) {
    setState(() {
      if (trendingTitle == null) {
        trendingMoviesTitle = [];
        return;
      }
      trendingMoviesTitle = trendingTitle;
    });
  }

  void getComingSoonMoviesID(id) {
    setState(() {
      if (id == null) {
        comingSoonMoviesID = [];
      }
      comingSoonMoviesID = id;
    });
  }

  void getTrendingMovieID(trendingId) {
    setState(() {
      if (trendingId == null) {
        trendingMovieID = [];
      }
      trendingMovieID = trendingId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          'FILMS',
          style: kBoldTextStyle,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return Search();
                }),
              );
            },
            iconSize: 30.0,
            color: kBoldTextColor,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            MoviePreText(
              text: 'Coming Soon',
              padding: EdgeInsets.only(left: 8.0),
              margin: EdgeInsets.symmetric(vertical: 15.0),
            ),
            ComingSoonMoviesList(),
            DefaultTabController(
              length: allMovieGenre.length,
              initialIndex: 0,
              child: TabBarContents(
                allMovieGenre: allMovieGenre,
                comingSoonMovies: movieList,
                trendingMovieTitle: trendingMoviesTitle,
              ),
            ),
            MoviePreText(
              text: 'Trending',
              padding: EdgeInsets.only(left: 8.0),
              margin: EdgeInsets.symmetric(vertical: 15.0),
            ),
            ImageCard(
//              movieOnPressed: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context){
//                  return Description(upcomingMovieID: trendingMovieID[ImageCard.ID]);
//                }));
//              },
              comingSoonMovies: trendingMovies,
              trendingMoviesTitle: trendingMoviesTitle,
              width: 160.0,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class ComingSoonMoviesList extends StatefulWidget {
  @override
  _ComingSoonMoviesListState createState() => _ComingSoonMoviesListState();
}

class _ComingSoonMoviesListState extends State<ComingSoonMoviesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Description(
                      upcomingMovieID: comingSoonMoviesID[index],
                    );
                  }));
                });
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Image(
                  fit: BoxFit.fill,
                  image: NetworkImage(comingSoonMovies[index]),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
//                color: Color(0xFFDDE8F3),
              color: Theme.of(context).primaryColor,
                elevation: 5.0,
              ),
            ),
          );
        },
        itemCount: comingSoonMovies.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
