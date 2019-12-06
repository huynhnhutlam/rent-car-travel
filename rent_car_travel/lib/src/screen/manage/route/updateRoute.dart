import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rent_car_travel/src/models/route.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rent_car_travel/src/models/place_item.dart';
import 'package:rent_car_travel/src/screen/map/place_picker_page.dart';

class UpdateRoute extends StatefulWidget {
  final Routes routes;

  const UpdateRoute({Key key, this.routes}) : super(key: key);
  @override
  _UpdateRouteState createState() => _UpdateRouteState();
}

class _UpdateRouteState extends State<UpdateRoute> {
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
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerName =
        TextEditingController(text: widget.routes.nameRoute);
    TextEditingController _controllerDes =
        TextEditingController(text: widget.routes.description);
    TextEditingController _controllerLatLng = TextEditingController(
        text: '${widget.routes.lat} - ${widget.routes.lng}');
    TextEditingController _controllerPrice4s =
        TextEditingController(text: '${widget.routes.price4Seats}');
    TextEditingController _controllerPrice7s =
        TextEditingController(text: '${widget.routes.price7Seats}');
    TextEditingController _controllerPrice16s =
        TextEditingController(text: '${widget.routes.price16Seats}');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          iconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          title: Text(
            'Cập nhật tuyến đường',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildImagePick(),
                _line(),
                Column(
                  children: <Widget>[
                    _textfeildInfo('Tên tuyến đường', _controllerName),
                    _selectedPickUp(
                        fromAddress == null
                            ? _controllerLatLng.text
                            : fromAddress.name,
                        _selectedPickUpPlace),
                    _textfeildInfo('Giá xe 4 chỗ', _controllerPrice4s),
                    _textfeildInfo('Giá xe 7 chỗ', _controllerPrice7s),
                    _textfeildInfo('Giá xe 16 chỗ', _controllerPrice16s),
                    _textFieldDescription('Mô tả ', _controllerDes),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        
                        _buttonCanCel(context),
                        SizedBox(width: 24,),
                        _buttonConfirm(onPressed: (){}),
                        
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildImagePick() {
    return Container(
      height: 200,
      child: _image == null
          ? Center(
              /*  child: Row(
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
              ), */
              child: ClipRect(
                child: CachedNetworkImage(
                  imageUrl: widget.routes.image,
                  fit: BoxFit.cover
                ),
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

Widget _buttonCanCel(BuildContext context) {
  return FlatButton(
    onPressed: () {
      /*showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              title: Text('Cập nhật'),
              content: Text('Bạn muốn hủy cập nhật ??'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Hủy'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Xác nhận'),
                )
              ],
            );
          });*/
      Navigator.pop(context);
    },
    child: Text('Hủy', style: TextStyle(color: Colors.blue)),
  );
}
