import 'package:flutter/material.dart';
class BookingList extends StatefulWidget {
  final String title;
  @override
  _BookingListState createState() => _BookingListState();

  BookingList(this.title);
}

class _BookingListState extends State<BookingList> {
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
