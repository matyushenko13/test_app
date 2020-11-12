import 'package:flutter/foundation.dart';

class LatLng{
  String id;
  String duration;
  String distance;
  double delay;

  LatLng({@required this.id, this.delay, this.distance, this.duration});
}