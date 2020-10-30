import 'package:flutter/material.dart';
import 'package:movie_app/screen/description.dart';
import 'package:movie_app/services/movie_pre_text.dart';
import 'package:movie_app/utilities/constants.dart';
import 'image_card.dart';
import 'gener_to_image_matcher.dart';


class TabBarContents extends StatefulWidget {
  TabBarContents(
      {@required this.allMovieGenre, @required this.comingSoonMovies, this.moviesOnPressed, this.trendingMovieTitle});

  final List<String> allMovieGenre;
   List<String> comingSoonMovies;
   final Function moviesOnPressed;
    List<String> trendingMovieTitle;


  @override
  State<StatefulWidget> createState() => _TabBarContentsState();
}

class _TabBarContentsState extends State<TabBarContents> {
  GenreMatcher sample = GenreMatcher();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.61,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: MoviePreText(text: 'Movies',padding: EdgeInsets.only(left: 8.0),),
          bottom: TabBar(
            labelStyle: kTabItemStyle,
            tabs: widget.allMovieGenre.map((String genre) {
              return Text(genre);
            }).toList(),
            isScrollable: true,
            labelColor: Color(0xFF384C70),
            unselectedLabelColor: Color(0xFFA5B4C7),
            indicatorColor: Colors.transparent,

            onTap: (selectedTabValue) async {
              var movies = await sample.getMoviesInGenre(widget.allMovieGenre[selectedTabValue]);
              var moviesTitle = await GenreMatcher.movieTitle;
              setState(() {
               widget.comingSoonMovies = movies;
               widget.trendingMovieTitle = moviesTitle;
              });
            },
          ),
        ),
        body: Container(
          child: TabBarView(
            children:
           widget.allMovieGenre.map((String genre) {
//              return ImageCard(
//                comingSoonMovies: widget.comingSoonMovies,
//                borderRadius: BorderRadius.circular(16.0),
//                trendingMoviesTitle: widget.trendingMovieTitle,
//                width: 160.0,
//
//              );
           return ListView.builder(
             itemBuilder: (context, index) {
               return Container(
                 width:160.0,
                 padding: EdgeInsets.all(4.0),
                 child: GestureDetector(
                   onTap: () async{
                     var id = await GenreMatcher.movieId;
                     print(id);
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                       return Description(upcomingMovieID: id[index],);
                     }));
                   },
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Card(
                         clipBehavior: Clip.antiAlias,
                         child: Image(
                           fit: BoxFit.fill,
                           image: NetworkImage(widget.comingSoonMovies[index]),
                         ),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(16.0),
                         ),
                         color: Color(0xFFDDE8F3),
                         elevation: 3.0,
                       ),

                       Container(
                         padding: EdgeInsets.only(left: 15.0),
                         child: Text(
                           widget.trendingMovieTitle[index],
                           style: TextStyle(
                             fontSize: 17.0,
                             color: kBoldTextColor,
                             fontWeight: FontWeight.w600,
                           ),

                         ),
                       )
                     ],
                   ),
                 ),
               );
             },
             itemCount: widget.comingSoonMovies.length,
             scrollDirection: Axis.horizontal,
           );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
