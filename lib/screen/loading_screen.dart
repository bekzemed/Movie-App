import 'package:flutter/material.dart';
import 'package:movie_app/services/networking.dart';
import 'package:movie_app/utilities/constants.dart';
import 'movie_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(seconds: 3),);
    animation = ColorTween(begin: Colors.black54, end: Colors.grey).animate(controller);

    controller.forward();
    controller.addListener((){
      setState(() {

      });
    });

    getMovieData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getMovieData() async {
    NetworkHelper networkHelper = NetworkHelper(kComingSoonMovies);
    NetworkHelper networkHelper2 = NetworkHelper(
        '$kApiUrl/genre/movie/list?api_key=$kApiKey&language=en-US');
    NetworkHelper networkHelper3 = NetworkHelper(kTrending);



    var comingSoon = await networkHelper.getComingSoonMovies();
    var movieList = await networkHelper.getMovieList();
    var genre = await networkHelper2.getAllGenre();
    var trending = await networkHelper3.getTrendingMovie();
    var trendingTitle = await networkHelper3.getTrendingMovieTitle();
    var id = await networkHelper.getMovieID();
    var trendingId = await networkHelper3.getMovieID();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MoviePage(
        movieData: comingSoon,
        allGenreName: genre,
        trendingMovies: trending,
        upcomingMovieID: id,
        movieList: movieList,
        trendingMoviesTitle: trendingTitle,
        trendingMovieID: trendingId,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: animation.value,
        ),
      ),
    );
  }
}
