// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_swagger.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ExampleSwagger extends ExampleSwagger {
  _$ExampleSwagger([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ExampleSwagger;

  @override
  Future<Response<dynamic>> createEstimation({EstimationRequest body}) {
    final $url = 'estimations';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getEstimation({String id}) {
    final $url = 'estimations/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
