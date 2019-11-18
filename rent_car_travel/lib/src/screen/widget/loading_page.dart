import 'package:flutter/material.dart';

class LoadingPageAnimation extends StatefulWidget {
  LoadingPageAnimation({Key key}) : super(key: key);

  createState() => LoadingPageAnimationState();
}

class LoadingPageAnimationState extends State<LoadingPageAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: _listItemAnim(),
      ),
    );
  }

  Widget _listItemAnim() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buildItem();
      },
    );
  }

  Widget _buildItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildContainerAnim(
              margin: EdgeInsets.only(right: 12),
              begin: Alignment(gradientPosition.value, 0)),
          Expanded(
              child: _buildContainerAnim(
                  height: 80, begin: Alignment(gradientPosition.value, 0)))
        ],
      ),
    );
  }
}

Widget _buildContainerAnim(
    {EdgeInsetsGeometry margin,
    Alignment begin,
    double width = 100,
    double height = 100}) {
  return Container(
    margin: margin,
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      gradient: LinearGradient(
        begin: begin,
        end: Alignment(-1, 0),
        colors: [Colors.grey[300], Colors.grey[200], Colors.grey[300]],
      ),
    ),
  );
}