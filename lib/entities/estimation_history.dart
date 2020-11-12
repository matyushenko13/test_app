import 'package:flutter/foundation.dart';

class EstimationHistory{
  String id;
  String duration;
  String distance;
  double delay;

  EstimationHistory({@required this.id, this.delay, this.distance, this.duration});
}