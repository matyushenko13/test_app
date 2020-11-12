import 'package:flutter/foundation.dart';
import 'package:test_app_checkbox/entities/estimation_history.dart';

abstract class GetEstimationState {}

class ViewStateGetEstimation extends GetEstimationState{
  @override
  String toString() {
    return 'ViewState';
  }
}

class WaitingStateGetEstimation extends GetEstimationState{
  @override
  String toString() {
    return 'WaitingState';
  }
}

class SuccessStateGetEstimation extends GetEstimationState{
  EstimationHistory estimation;
  SuccessStateGetEstimation({@required this.estimation});

  @override
  String toString() {
    return 'SuccessState';
  }
}

class ErrorStateGetEstimation extends GetEstimationState{
  final String message;
  ErrorStateGetEstimation({this.message});

  @override
  String toString() {
    return 'Error - $message';
  }
}