import 'package:flutter/material.dart';
import 'package:movie_app/screen/description.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> image = [];
  List<String> description = [];
  List<String> title = [];
  List<int> id = [];

  final _controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 15.0,
        backgroundColor: Color(0xFFDDE8F3),
        title: TextField(
            controller: _controller,
            autocorrect: true,
            cursorColor: kBoldTextColor,
            style: TextStyle(
              color: Color(0xFF384C70),
              fontSize: 20.0,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(
                color: kBoldTextColor,
              ),
            ),
            onChanged: (value) async {
              if (image != null && description != null && title != null && id != null) {
                image.clear();
                description.clear();
                title.clear();
                id.clear();
              }

              Response response = await get(
                  'https://api.themoviedb.org/3/search/movie?query=$value&api_key=409a8c470c048a5117186678fbe24223');
              if (response.statusCode == 200) {
                var data = response.body;
                List result = jsonDecode(data)['results'];
                for (int i = 0; i < result.length; i++) {
                  setState(() {
                    image.add(kReduceImageApi +
                        jsonDecode(data)['results'][i]['poster_path']);
                    description.add(jsonDecode(data)['results'][i]['overview']);
                    title.add(jsonDecode(data)['results'][i]['title']);
                    id.add(jsonDecode(data)['results'][i]['id']);
                  });
                }
//              setState(() {
//                myTitle = title;
//                myImage = image;
//                myDescription = description;
//              });
              } else {
                print(response.statusCode);
              }
            }),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _controller.clear();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Description(upcomingMovieID: id[index],);
                  }));
                },
                child: Card(

                  margin: EdgeInsets.all(10.0),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Material(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        child: Image(
                          height: MediaQuery.of(context).size.height * 0.25,
                          fit: BoxFit.fill,
                          image: NetworkImage(image[index]),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                title[index],
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 10.0, bottom: 10.0),
                              child: Text(
                                description[index],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
//                  color: Color(0xFFDDE8F3),
                  color: Theme.of(context).primaryColor,
                  elevation: 5.0,
                ),
              );
            },
            itemCount: image.length,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }
}
