import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:rent_car_travel/src/models/model_route.dart';

part 'serializers.g.dart';

@SerializersFor(const [Routes])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();