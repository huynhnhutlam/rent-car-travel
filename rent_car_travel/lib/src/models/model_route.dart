import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'model_route.g.dart';

abstract class Routes implements Built<Routes, RoutesBuilder> {
  // IDs are set in the back-end.
  // In a POST request, BuiltPost's ID will be null.
  // Only BuiltPosts obtained through a GET request will have an ID.
  @nullable
  int get id;

  String get nameRoute;
  String get image;
  String get description;
  double get rating;

  Routes._();

  factory Routes([updates(RoutesBuilder b)]) = _$Routes;

  static Serializer<Routes> get serializer => _$routesSerializer;
}