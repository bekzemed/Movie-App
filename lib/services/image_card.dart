import 'package:flutter/material.dart';
import 'package:movie_app/services/networking.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/screen/description.dart';




class ImageCard extends StatefulWidget {

  ImageCard({@required this.comingSoonMovies, this.borderRadius, this.width, this.movieOnPressed, this.trendingMoviesTitle, this.ID});

  final List<String> comingSoonMovies;
  final BorderRadius borderRadius;
  final double width;
  final Function movieOnPressed;
  final List<String> trendingMoviesTitle;
   int ID;



  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  List<int> myId = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrendingMovieID();
  }


  void getTrendingMovieID() async{
    NetworkHelper networkHelper = NetworkHelper(kTrending);
    var newId = await networkHelper.getTrendingMovieID();
    setState(() {
      myId = newId;
    });
    print(myId);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.455,
      child: ListView.builder(
        itemBuilder: (context, index) {
          widget.ID = index;
          return Container(
            width: widget.width,
            padding: EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Description(upcomingMovieID: myId[index]);
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
                      borderRadius: widget.borderRadius,
                    ),
                    color: Color(0xFFDDE8F3),
                    elevation: 3.0,
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      widget.trendingMoviesTitle[index],
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
      ),

    );
  }
}

