import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final double height;
  final double width;
  final EdgeInsetsGeometry margin;
  LoadingWidget({Key key, this.height = 100, this.width = 200, this.margin})
      : super(key: key);

  createState() => LoadingWidgetState();
}

class LoadingWidgetState extends State<LoadingWidget>
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
        child: Container(
          margin: widget.margin,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              begin: Alignment(gradientPosition.value, 0),
              end: Alignment(-1, 0),
              colors: [Colors.grey[300], Colors.grey[200], Colors.grey[300]],
            ),
          ),
        ),
      ),
    );
  }
}
