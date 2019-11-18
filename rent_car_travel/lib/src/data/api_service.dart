import 'package:chopper/chopper.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rent_car_travel/src/data/convert/built_value_convert.dart';
import 'package:rent_car_travel/src/models/model_route.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '/route')
abstract class RouteApi extends ChopperService {
  @Get()
  Future<Response<BuiltList<Routes>>> getPosts();
  @Get(path: '/{id}')
   Future<Response<Routes>> getPost(@Path('id') int id);

  @Post()
 Future<Response<Routes>> postPost(
    @Body() Routes post,
  );
  static RouteApi create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: 'https://my-json-server.typicode.com/huynhnhutlam/demoJson',
      services: [
        // The generated implementation
        _$RouteApi(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: BuiltValueConverter(),
      interceptors: [
      (Request request) async {
        if (request.method == HttpMethod.Post) {
          chopperLogger.info('Performed a POST request');
        }
        return request;
      },
      (Response response) async {
        if (response.statusCode == 404) {
          chopperLogger.severe('404 NOT FOUND');
        }
        return response;
      },
    ],
    );

    // The generated class with the ChopperClient passed in
    return _$RouteApi(client);
  }
}
