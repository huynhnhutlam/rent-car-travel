import 'package:flutter/material.dart';

class TitleHome extends StatelessWidget {
  final String text;
  final Function onTap;
  final String txtSeemore;

  TitleHome({
    this.text,
    this.onTap,
    this.txtSeemore = 'See more'
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            text,
            style: TextStyle(color: Colors.cyan[300]),
          ),
          new InkWell(
            onTap: onTap,
            child: Text(txtSeemore,
                style: TextStyle(
                    color: Colors.cyan[300], fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }
}
