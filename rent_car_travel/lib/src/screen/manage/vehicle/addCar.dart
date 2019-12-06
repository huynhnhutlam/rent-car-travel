import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerNum = TextEditingController();
  TextEditingController _controllerLp = TextEditingController();
  TextEditingController _controllerDes = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
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
            children: <Widget>[
              _buildImagePick(),
              _textfeildInfo('Tên xe', _controllerName),
              _textfeildInfo('Chỗ ngồi', _controllerNum),
              _textfeildInfo('Biển số', _controllerLp),
              _textfeildInfo('Giá', _controllerPrice),
              _textFieldDescription('Mô tả', _controllerDes),
              _buttonConfirm(onPressed: (){})
            ],
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
Widget _buttonConfirm({Function onPressed}) {
  return FlatButton(
    onPressed: onPressed,
    child: Text('Xác nhận', style: TextStyle(color: Colors.blue)),
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
