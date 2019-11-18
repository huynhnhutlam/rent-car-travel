import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Text('4.3',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                _starRatingWidget(20),
                SizedBox(height: 10),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: <Widget>[],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Text('Bình luận',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: <Widget>[
                _commentSection(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(
                    indent: 8,
                  ),
                ),
                _commentSection()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _starRatingWidget(double widgetSize) {
  return Container(
      child: Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      return InkWell(
        onTap: () {},
        child: Icon(
          Icons.star,
          color: Colors.yellow,
          size: widgetSize,
        ),
      );
    }),
  ));
}

Widget _commentSection() {
  final Widget iconStar = Icon(Icons.star);
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _circleAvatar(
                    NetworkImage(
                        'https://images-na.ssl-images-amazon.com/images/I/612z36b4PrL._SX425_.jpg'),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text(
                            'Manh Lu',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text('3 ngày trước'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                   ''),
              ),
            ],
          ),
        ),
        Container(child: _buildImageComment()),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: FlatButton.icon(
                  onPressed: () {},
                  icon: iconStar,
                  label: Text('0 Likes'),
                ),
              ),
              Container(
                child: FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.comment),
                  label: Text('0 Phản hồi'),
                ),
              ),
            ],
          ),
        ),
        _replySection(),
      ],
    ),
  );
}

Widget _buildImageComment() {
  return Container(
    height: 220,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _imageComment(
            height: 210,
            width: 210,
            image: NetworkImage(
                'https://images-na.ssl-images-amazon.com/images/I/612z36b4PrL._SX425_.jpg')),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _imageComment(
                image: NetworkImage(
                    'https://images-na.ssl-images-amazon.com/images/I/612z36b4PrL._SX425_.jpg')),
            _imageComment(
                image: NetworkImage(
                    'https://images-na.ssl-images-amazon.com/images/I/612z36b4PrL._SX425_.jpg')),
          ],
        ),
      ],
    ),
  );
}

Widget _imageComment(
    {double height = 100, double width = 120, ImageProvider<dynamic> image}) {
  return Flexible(
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: image, fit: BoxFit.cover),
      ),
    ),
  );
}

Widget _replySection() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(style: BorderStyle.none),
        borderRadius: BorderRadius.circular(8)),
    child: Column(
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _commentName(
                textName: 'Lam Huynh',
                time: '1 ngày trước',
                avatar: NetworkImage(
                    'https://images-na.ssl-images-amazon.com/images/I/612z36b4PrL._SX425_.jpg'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('Poor you'),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          child: Text(
                            'Trả lời',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          child: Text(
                            'Like',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 24), child: _replyCommentSection())
      ],
    ),
  );
}

Widget _replyCommentSection() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _commentName(
          textName: 'Lam Huynh',
          time: '1 ngày trước',
          avatar: NetworkImage(
              'https://images-na.ssl-images-amazon.com/images/I/612z36b4PrL._SX425_.jpg'),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child:
              Text(''''''),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: <Widget>[
              Container(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    child: Text(
                      'Trả lời',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.amber),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 24),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    child: Text(
                      'Like',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.amber),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _circleAvatar(ImageProvider image) {
  return CircleAvatar(
    backgroundImage: image,
    radius: 20,
  );
}

Widget _commentName({String textName, String time, ImageProvider avatar}) {
  TextStyle styleName = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle styleTime = TextStyle(
    color: Color(0xFF737373),
    fontSize: 12,
  );
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Row(
      children: <Widget>[
        _circleAvatar(
          avatar,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Text(
                textName,
                style: styleName,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Text(
                time,
                style: styleTime,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
