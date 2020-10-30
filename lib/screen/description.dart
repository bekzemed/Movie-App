import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/services/movie_pre_text.dart';
import 'package:movie_app/services/networking.dart';
import 'package:url_launcher/url_launcher.dart';

class Description extends StatefulWidget {
  Description({
    @required this.upcomingMovieID,
  });

  final int upcomingMovieID;

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieData(widget.upcomingMovieID);
  }

  String images;
  String title;
  double vote;
  List<String> genre;
  String description;
  int runTime;
  String videoKey;

  Future getMovieData(id) async {
    if (id == null) {
      images = '';
    }
    NetworkHelper networkHelper = NetworkHelper('$kComingSoonMovies');
    var newImages = await networkHelper.getMovieImageByID(id);
    var newTitle = await networkHelper.getMovieTitleByID(id);
    var newVote = await networkHelper.getMovieVote(id);
    var newGenre = await networkHelper.getGenreById(id);
    var newDescription = await networkHelper.getMovieDescriptionByID(id);
    var newRunTime = await networkHelper.getMovieRunTimeByID(id);
    var newVideo = await networkHelper.getVideosByID(id);
    setState(() {
      images = newImages;
      title = newTitle;
      vote = newVote;
      genre = newGenre;
      description = newDescription;
      runTime = newRunTime;
      videoKey = newVideo;
    });
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'couldnt launch the $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
          Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(0.0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: images != null
                        ? Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(images),
                            height: MediaQuery.of(context).size.height * 0.7,
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: SpinKitFadingCircle(
                              color: Colors.grey,
                            )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0)),
                    ),
                    color: Color(0xFFDDE8F3),
                    elevation: 3.0,
                  ),
                ],
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  var url = "https://www.youtube.com/watch?v=$videoKey";

                  _launchUrl(url);
                },
                tooltip: 'redirect to youtube',
                label: Text('Movie'),
                icon: Icon(Icons.movie),
                backgroundColor: Colors.grey[800],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: title != null
                            ? MoviePreText(
                                text: '$title',
                              )
                            : Container(
                              margin: EdgeInsets.only(bottom: 8.0),
                              child: UnconstrainedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Placeholder(
                                    color: Theme.of(context).textSelectionColor,
                                    fallbackWidth: 100.0,
                                    fallbackHeight: 15.0,
                                  ),
                                ),
                            ),
                      ),
                      vote != null
                          ? MoviePreText(
                              text: '$vote',
                            )
                          : UnconstrainedBox(
                              child: Placeholder(
                                color: Theme.of(context).textSelectionColor,
                                fallbackHeight: 15.0,
                                fallbackWidth: 55.0,
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: genre != null
                          ? genre
                              .map((name) => new Text(
                                    name + ' ',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Theme.of(context).splashColor),
                                  ))
                              .toList()
                          : <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 8.0),
                                child: UnconstrainedBox(
                                  child: Placeholder(
                                    color: Theme.of(context).splashColor,
                                    fallbackHeight: 15.0,
                                    fallbackWidth: 80.0,
                                  ),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: runTime != null
                        ? Text(
                            runTime.toString() + ' min',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Theme.of(context).splashColor),
                          )
                        : UnconstrainedBox(
                            child: Placeholder(
                              color: Theme.of(context).splashColor,
                              fallbackHeight: 15.0,
                              fallbackWidth: 55.0,
                            ),
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MoviePreText(
                      text: 'Description',
                    ),
                  ),
                ),
                description != null
                    ? Text(
                        '$description',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).textSelectionColor,
                          wordSpacing: 2.5,
                        ),
                      )
                    : UnconstrainedBox(
                        child: Placeholder(
                          color: Theme.of(context).textSelectionColor,
                          fallbackHeight: 200.0,
                          fallbackWidth: MediaQuery.of(context).size.width - 30.0,
                        ),
                      ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
