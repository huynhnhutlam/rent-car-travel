import 'package:flutter/material.dart';
class RouteList extends StatefulWidget {
  final String title;

  RouteList(this.title);

  @override
  _RouteListState createState() => _RouteListState();
}

class _RouteListState extends State<RouteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(widget.title, style: TextStyle(color: Colors.blue,fontSize: 18),),
      ),
      body: _buildBody(),
    );
  }
  Widget _buildBody(){
    return Container();
  }
}
