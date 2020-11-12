// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_swagger.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Point _$PointFromJson(Map<String, dynamic> json) {
  return Point(
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PointToJson(Point instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

EstimationRequest _$EstimationRequestFromJson(Map<String, dynamic> json) {
  return EstimationRequest(
    from: json['from'] == null
        ? null
        : Point.fromJson(json['from'] as Map<String, dynamic>),
    to: json['to'] == null
        ? null
        : Point.fromJson(json['to'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EstimationRequestToJson(EstimationRequest instance) =>
    <String, dynamic>{
      'from': instance.from?.toJson(),
      'to': instance.to?.toJson(),
    };

Estimation _$EstimationFromJson(Map<String, dynamic> json) {
  return Estimation(
    id: json['id'] as String,
    from: json['from'] == null
        ? null
        : Point.fromJson(json['from'] as Map<String, dynamic>),
    to: json['to'] == null
        ? null
        : Point.fromJson(json['to'] as Map<String, dynamic>),
    duration: (json['duration'] as num)?.toDouble(),
    distance: (json['distance'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$EstimationToJson(Estimation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from': instance.from?.toJson(),
      'to': instance.to?.toJson(),
      'duration': instance.duration,
      'distance': instance.distance,
    };
