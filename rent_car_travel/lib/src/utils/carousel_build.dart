import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:w2f/src/utils/theme_maneger.dart';

class CarouselBuild extends StatefulWidget {
  CarouselBuild(
      {Key key,
      this.imageUrls,
      this.animationCurve = Curves.ease,
      this.borderRadius = 0,
      this.animationDuration = const Duration(milliseconds: 300),
      this.autoplayDuration = const Duration(seconds: 3),
      this.autoplay = true})
      : super(key: key);
  final List<String> imageUrls;
  final bool autoplay;
  final Curve animationCurve;
  final Duration animationDuration;
  final Duration autoplayDuration;
  final double borderRadius;

  @override
  _CarouselBuildState createState() => _CarouselBuildState();
}

class _CarouselBuildState extends State<CarouselBuild> {
  int _pos = 0;
  final _controller = new PageController();

  @override
  void initState() {
    super.initState();

    if (widget.autoplay) {
      new Timer.periodic(widget.autoplayDuration, (_) {
        if (_controller.hasClients) {
          if (_controller.page == widget.imageUrls.length - 1) {
            _controller.animateToPage(
              0,
              duration: widget.animationDuration,
              curve: widget.animationCurve,
            );
          } else {
            _controller.nextPage(
                duration: widget.animationDuration,
                curve: widget.animationCurve);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        _buildPageView(context, radius: widget.borderRadius),
        _buildDotIncator(context),
      ],
    );
  }

  Widget _buildPageView(BuildContext context, {double radius}) => new PageView(
        children: _buildPageViewChildren(context, radius),
        onPageChanged: this.onPageChanged(),
        physics: new AlwaysScrollableScrollPhysics(),
        controller: _controller,
      );

  List<Widget> _buildPageViewChildren(BuildContext context, double radius) {
    return this
        .widget
        .imageUrls
        .map((String url) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
              ),
              child: CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
            ))
        .toList();
  }

  Widget _buildDotIncator(BuildContext context) {
    return new Positioned(
      bottom: 10.0,
      child: Center(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: _buildDots(context),
        ),
      ),
      left: 0,
      right: 0,
    );
  }

  List<Widget> _buildDots(BuildContext context) {
    return this.widget.imageUrls.map((String url) {
      final isSelected = this.widget.imageUrls.indexOf(url) == this._pos;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white10,
          shape: BoxShape.circle,
        ),
        width: 10.0,
        height: 10.0,
        child: InkWell(
          onTap: () {},
        ),
      );
    }).toList();
  }

  ValueChanged<int> onPageChanged() => (int pos) {
        this.setState(() => this._pos = pos);
      };
}
