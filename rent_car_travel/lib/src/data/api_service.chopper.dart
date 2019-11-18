// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$RouteApi extends RouteApi {
  _$RouteApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = RouteApi;

  Future<Response<BuiltList<Routes>>> getPosts() {
    final $url = '/route';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<BuiltList<Routes>, Routes>($request);
  }

  Future<Response<Routes>> getPost(int id) {
    final $url = '/route/${id.toInt()}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Routes, Routes>($request);
  }

  Future<Response<Routes>> postPost(Routes post) {
    final $url = '/route';
    final $body = post;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Routes, Routes>($request);
  }
}
