import 'package:json_annotation/json_annotation.dart';
import 'package:chopper/chopper.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter/widgets.dart';

import 'example_swagger.enums.swagger.dart' as enums;

part 'example_swagger.swagger.chopper.dart';
part 'example_swagger.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class ExampleSwagger extends ChopperService {
  static ExampleSwagger create([ChopperClient client]) {
    if (client != null) {
      return _$ExampleSwagger(client);
    }

    final newClient = ChopperClient(
        services: [_$ExampleSwagger()],
        converter: JsonSerializableConverter(),
        baseUrl: 'https://estimation-demo.dev.checkbox.ru/');
    return _$ExampleSwagger(newClient);
  }

  ///Create a new estimation
  ///@param body

  @Post(path: 'estimations')
  Future<chopper.Response> createEstimation({@Body() EstimationRequest body});

  ///Return calculated estimation
  ///@param id

  @Get(path: 'estimations/{id}')
  Future<chopper.Response> getEstimation({@Path('id') @required String id});
}

final Map<Type, Object Function(Map<String, dynamic>)>
    ExampleSwaggerJsonDecoderMappings = {
  Point: Point.fromJsonFactory,
  EstimationRequest: EstimationRequest.fromJsonFactory,
  Estimation: Estimation.fromJsonFactory,
};

@JsonSerializable(explicitToJson: true)
class Point {
  Point({
    this.lat,
    this.lng,
  });

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);

  @JsonKey(name: 'lat')
  final double lat;
  @JsonKey(name: 'lng')
  final double lng;
  static const fromJsonFactory = _$PointFromJson;
  static const toJsonFactory = _$PointToJson;
  Map<String, dynamic> toJson() => _$PointToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EstimationRequest {
  EstimationRequest({
    this.from,
    this.to,
  });

  factory EstimationRequest.fromJson(Map<String, dynamic> json) =>
      _$EstimationRequestFromJson(json);

  @JsonKey(name: 'from')
  final Point from;
  @JsonKey(name: 'to')
  final Point to;
  static const fromJsonFactory = _$EstimationRequestFromJson;
  static const toJsonFactory = _$EstimationRequestToJson;
  Map<String, dynamic> toJson() => _$EstimationRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Estimation {
  Estimation({
    this.id,
    this.from,
    this.to,
    this.duration,
    this.distance,
  });

  factory Estimation.fromJson(Map<String, dynamic> json) =>
      _$EstimationFromJson(json);

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'from')
  final Point from;
  @JsonKey(name: 'to')
  final Point to;
  @JsonKey(name: 'duration')
  final double duration;
  @JsonKey(name: 'distance')
  final double distance;
  static const fromJsonFactory = _$EstimationFromJson;
  static const toJsonFactory = _$EstimationToJson;
  Map<String, dynamic> toJson() => _$EstimationToJson(this);
}

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

class CustomJsonDecoder {
  CustomJsonDecoder(this.factories);

  final Map<Type, JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values) as T;
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class JsonSerializableConverter extends chopper.JsonConverter {
  @override
  chopper.Response<ResultType> convertResponse<ResultType, Item>(
      chopper.Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final jsonDecoder = CustomJsonDecoder(ExampleSwaggerJsonDecoderMappings);
