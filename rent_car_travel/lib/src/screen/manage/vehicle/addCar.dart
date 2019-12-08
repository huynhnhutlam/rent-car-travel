import 'dart:convert';
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
    Future<File> _image;
  String base64Image;
  File tmpFile;
   getImageCamera(){
    setState(() {
      _image = ImagePicker.pickImage(source: ImageSource.camera);
    });
  }

  getImageGallery() {
    var image =  ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  /*startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }
*/
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
              SizedBox(height: 8,),
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
      child: FutureBuilder<File>(
        future: _image,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              null != snapshot.data) {
            tmpFile = snapshot.data;
            base64Image = base64Encode(snapshot.data.readAsBytesSync());
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.file(
                snapshot.data,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            );
          } else if (null != snapshot.error) {
            return const Text(
              'Error Picking Image',
              textAlign: TextAlign.center,
            );
          } else {
            return Center(
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
            );
          }
        },
      )
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
