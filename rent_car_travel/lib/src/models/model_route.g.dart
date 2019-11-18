// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_route.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Routes> _$routesSerializer = new _$RoutesSerializer();

class _$RoutesSerializer implements StructuredSerializer<Routes> {
  @override
  final Iterable<Type> types = const [Routes, _$Routes];
  @override
  final String wireName = 'Routes';

  @override
  Iterable<Object> serialize(Serializers serializers, Routes object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'nameRoute',
      serializers.serialize(object.nameRoute,
          specifiedType: const FullType(String)),
      'image',
      serializers.serialize(object.image,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'rating',
      serializers.serialize(object.rating,
          specifiedType: const FullType(double)),
    ];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Routes deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RoutesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'nameRoute':
          result.nameRoute = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$Routes extends Routes {
  @override
  final int id;
  @override
  final String nameRoute;
  @override
  final String image;
  @override
  final String description;
  @override
  final double rating;

  factory _$Routes([void Function(RoutesBuilder) updates]) =>
      (new RoutesBuilder()..update(updates)).build();

  _$Routes._(
      {this.id, this.nameRoute, this.image, this.description, this.rating})
      : super._() {
    if (nameRoute == null) {
      throw new BuiltValueNullFieldError('Routes', 'nameRoute');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('Routes', 'image');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Routes', 'description');
    }
    if (rating == null) {
      throw new BuiltValueNullFieldError('Routes', 'rating');
    }
  }

  @override
  Routes rebuild(void Function(RoutesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RoutesBuilder toBuilder() => new RoutesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Routes &&
        id == other.id &&
        nameRoute == other.nameRoute &&
        image == other.image &&
        description == other.description &&
        rating == other.rating;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), nameRoute.hashCode), image.hashCode),
            description.hashCode),
        rating.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Routes')
          ..add('id', id)
          ..add('nameRoute', nameRoute)
          ..add('image', image)
          ..add('description', description)
          ..add('rating', rating))
        .toString();
  }
}

class RoutesBuilder implements Builder<Routes, RoutesBuilder> {
  _$Routes _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _nameRoute;
  String get nameRoute => _$this._nameRoute;
  set nameRoute(String nameRoute) => _$this._nameRoute = nameRoute;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  double _rating;
  double get rating => _$this._rating;
  set rating(double rating) => _$this._rating = rating;

  RoutesBuilder();

  RoutesBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _nameRoute = _$v.nameRoute;
      _image = _$v.image;
      _description = _$v.description;
      _rating = _$v.rating;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Routes other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Routes;
  }

  @override
  void update(void Function(RoutesBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Routes build() {
    final _$result = _$v ??
        new _$Routes._(
            id: id,
            nameRoute: nameRoute,
            image: image,
            description: description,
            rating: rating);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
