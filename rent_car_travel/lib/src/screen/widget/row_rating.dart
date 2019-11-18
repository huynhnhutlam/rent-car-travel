import 'package:flutter/material.dart';
class StarRating extends StatelessWidget {
  final double value;
  final IconData filledStar;
  final IconData unfilledStar;
  final double size;
  const StarRating({
    Key key,
    this.value = 0,
    this.filledStar,
    this.unfilledStar,
    this.size = 20
  })  : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = Colors.yellow;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return InkWell(
          child: Icon(
            index < value
                ? filledStar ?? Icons.star
                : unfilledStar ?? Icons.star_border,
            color: color,
            size: size,
          ),
        );
      }),
    );
  }
}
