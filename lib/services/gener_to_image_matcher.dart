import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/services/networking.dart';

class GenreMatcher {
  static var movieTitle;
  static var movieId;

  Future getMoviesInGenre(String genre) async {
    var movies;
    var url;

    if (genre == 'Action') {
      url = kActionGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Adventure') {
      url = kAdventureGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Animation') {
      url = kAnimationGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Comedy') {
      url = kComedyGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Crime') {
      url = kCrimeGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Documentary') {
      url = kDocumentaryGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Drama') {
      url = kDramaGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Family') {
      url = kFamilyGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Fantasy') {
      url = kFantasyGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'History') {
      url = kHistoryGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Horror') {
      url = kHorrorGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Music') {
      url = kMusicGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Mystery') {
      url = kMysteryGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Romance') {
      url = kRomanceGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Science Fiction') {
      url = kScienceFictionGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'Thriller') {
      url = kThrillerGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else if (genre == 'War') {
      url = kWarGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    } else {
      url = kWesternGenre;
      NetworkHelper networkHelper = NetworkHelper(url);
      movies = networkHelper.getMovieList();
      movieId = networkHelper.getMovieID();
      movieTitle = networkHelper.getTrendingMovieTitle();
    }

    return movies;
  }
}
