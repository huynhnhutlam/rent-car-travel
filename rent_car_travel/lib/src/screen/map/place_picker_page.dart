import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_car_travel/src/bloc/place_bloc.dart';
import 'package:rent_car_travel/src/bloc/place_notifer.dart';
import 'package:rent_car_travel/src/models/place_item.dart';

class PlacePickerPage extends StatefulWidget {
  final String selectedAddress;
  final Function(PlaceItemRes, bool) onSelected;
  final bool _isFromAddress;
  PlacePickerPage(this.selectedAddress, this.onSelected, this._isFromAddress);

  @override
  _RidePickerPageState createState() => _RidePickerPageState();
}

class _RidePickerPageState extends State<PlacePickerPage> {
  var _addressController;
  var placeBloc = PlaceBloc();

  @override
  void initState() {
    _addressController = TextEditingController(text: widget.selectedAddress);
    super.initState();
  }

  @override
  void dispose() {
    placeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: _buildSearchBar(),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Color(0xfff8f8f8),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20),
              child: StreamBuilder(
                  stream: placeBloc.placeStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == "start") {
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      }
                      List<PlaceItemRes> places = snapshot.data;
                      return ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          physics: ScrollPhysics(),
                          itemCount: places.length,
                          separatorBuilder: (context, index) => Container(
                                height: 1,
                                color: Color(0xffb7b7b7),
                              ),
                          itemBuilder: (context, index) {
                            return _buildListPlace(places, index);
                          });
                    } else {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: _currentAddress('Current Address'),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListPlace(List<PlaceItemRes> places, int index) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.location_on,
                size: 20,
                color: Color(0xFFb7b7b7),
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    places.elementAt(index).name == null
                        ? ''
                        : places.elementAt(index).name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                    places.elementAt(index).address == null
                        ? ''
                        : places.elementAt(index).address,
                    style: TextStyle(
                      color: Color(0xFF737373),
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).pop();
        widget.onSelected(places.elementAt(index), widget._isFromAddress);
      },
    );
  }

  Widget _currentAddress(String currentAddress, {List<PlaceItemRes> place, Function onPressed}) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 12),
            child: Icon(Icons.my_location),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Text('Vị trí hiện tại'),
              ),
              Text(
                currentAddress,
                style: TextStyle(color: Color(0xFF737373), fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 20,
          ),
        ),
        Container(
          height: 40,
          width: 290,
          color: Color(0xFFf7f7f7),
          child: _buildTextInputSearchBar('Địa điểm muốn tìm?'),
        ),
      ],
    );
  }

  Widget _buildTextInputSearchBar(String hintText) {
    return TextField(
      controller: _addressController,
      onSubmitted: (str) {
        placeBloc.searchPlace(str);
      },
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Color(0xFFadadad)),
          icon: Container(
              margin: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.location_on,
                size: 16,
              )),
          suffixIcon: InkWell(
            onTap: () {
              _addressController.text = '';
            },
            child: Icon(
              Icons.close,
              size: 18,
            ),
          )),
    );
  }
}
