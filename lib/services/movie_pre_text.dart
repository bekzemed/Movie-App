import 'package:flutter/material.dart';
import 'package:movie_app/utilities/constants.dart';

class MoviePreText extends StatelessWidget {
  MoviePreText({@required this.text, this.padding, this.margin});

  final String text;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Text(
        text,
        style: kBoldComingTextStyle,
      ),
    );
  }
}
