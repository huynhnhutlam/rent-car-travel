import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/screen/map/place_picker_page.dart';

class AddRoute extends StatefulWidget {
  @override
  _AddRouteState createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {
  File _image;

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  PlaceItemRes fromAddress;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerDes = TextEditingController();
  TextEditingController _controllerPrice4s = TextEditingController();
  TextEditingController _controllerPrice7s = TextEditingController();
  TextEditingController _controllerPrice16s = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          'Thêm mới',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[_buildImagePick(), _line(), _buildInfo(),SizedBox(height: 8,),_buttonConfirm(onPressed: (){})],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePick() {
    return Container(
      height: 200,
      child: _image == null
          ? Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buttonImagePick('Chụp hình', 'camera',
                      icon: Icons.camera_alt, onPressed: getImageCamera),
                  SizedBox(
                    width: 30,
                  ),
                  _buttonImagePick('Thư viện', 'gallery',
                      icon: Icons.dashboard, onPressed: getImageGallery),
                ],
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.file(
                _image,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  Widget _buildInfo() {
    return Column(
      children: <Widget>[
        _textfeildInfo('Tên tuyến đường', _controllerName),
        _selectedPickUp(
            fromAddress == null ? '' : fromAddress.name, _selectedPickUpPlace),
        _textfeildInfo('Giá xe 4 chỗ', _controllerPrice4s),
        _textfeildInfo('Giá xe 7 chỗ', _controllerPrice7s),
        _textfeildInfo('Giá xe 16 chỗ', _controllerPrice16s),
        _textFieldDescription('Mô tả ', _controllerDes)
      ],
    );
  }

  Widget _selectedPickUp(
    String title,
    Function onPressed,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Vị trí',
              style: TextStyle(
                  color: Color(0xFF737373),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 8),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(213, 213, 213, 0.34)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: _textRoute(title, onPressed: onPressed),
          )
        ],
      ),
    );
  }

  void _selectedPickUpPlace() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePickerPage(
                fromAddress == null ? "" : fromAddress.name, (place, isFrom) {
              fromAddress = place;
              setState(() {});
            }, true)));
  }
}

Widget _textRoute(String title, {Function onPressed}) {
  final TextStyle hintStyle = TextStyle(color: Color(0xFFadadad), fontSize: 12);
  final TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 14);
  return InkWell(
    onTap: onPressed,
    child: Container(
      height: 30,
      alignment: Alignment.centerLeft,
      width: double.maxFinite,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: title == 'Chọn vị trí' ? hintStyle : textStyle,
      ),
    ),
  );
}

Widget _buttonImagePick(String title, Object hero,
    {Function onPressed, IconData icon}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      FloatingActionButton(
        heroTag: hero,
        backgroundColor: Colors.grey[100],
        onPressed: onPressed,
        child: Icon(icon, color: Colors.black),
      ),
      SizedBox(height: 8),
      Text(title, style: TextStyle(color: Color(0xFF737373), fontSize: 10))
    ],
  );
}

Widget _textfeildInfo(String title, TextEditingController controller) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xFF737373),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(213, 213, 213, 0.34))),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(213, 213, 213, 0.34))),
          ),
        )
      ],
    ),
  );
}

Widget _textFieldDescription(String title, TextEditingController controller) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xFF737373),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(213, 213, 213, 0.34))),
            border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromRGBO(213, 213, 213, 0.34))),
          ),
        )
      ],
    ),
  );
}

Widget _line() {
  return Container(
    height: 1,
    margin: EdgeInsets.symmetric(vertical: 16),
    color: Color.fromRGBO(213, 213, 213, 0.34),
  );
}
Widget _buttonConfirm({Function onPressed}) {
  return FlatButton(
    onPressed: onPressed,
    child: Text('Xác nhận', style: TextStyle(color: Colors.blue)),
  );
}
