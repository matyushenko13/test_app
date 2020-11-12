import 'package:flutter/foundation.dart';
import 'package:test_app_checkbox/entities/estimation_history.dart';

abstract class SearchEstimationState {}

class ViewStateSearchEstimation extends SearchEstimationState{
  @override
  String toString() {
    return 'ViewState';
  }
}

class WaitingStateSearchEstimation extends SearchEstimationState{
  @override
  String toString() {
    return 'WaitingState';
  }
}

class SuccessStateSearchEstimation extends SearchEstimationState{
  LatLng estimation;
  SuccessStateSearchEstimation({@required this.estimation});

  @override
  String toString() {
    return 'SuccessState';
  }
}

class ErrorStateSearchEstimation extends SearchEstimationState{
  final String message;
  ErrorStateSearchEstimation({this.message});

  @override
  String toString() {
    return 'Error - $message';
  }
}