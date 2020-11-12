import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_checkbox/entities/estimation_history.dart';
import 'package:test_app_checkbox/generated_code/example_swagger.swagger.dart';
import 'package:test_app_checkbox/tools/validation.dart';
import 'package:test_app_checkbox/utils/app_strings.dart';
import 'get_estimation_state.dart';

class GetEstimationBloc extends Cubit<GetEstimationState>{
  GetEstimationBloc() : super(ViewStateGetEstimation());

  void submit({
  @required String from,
  @required String to,
  }) async {
    this.emit(WaitingStateGetEstimation());
    Point fromPoint = await _parse(value: from);
    Point toPoint = await _parse(value: to);

    if(fromPoint != null && toPoint != null) {
      final client = ExampleSwagger.create();

      final result = await client.createEstimation(body: EstimationRequest(
        from: fromPoint,
        to: toPoint,
      ));

      if (result.isSuccessful) {
        Estimation estimation = Estimation.fromJsonFactory(result.body);
        this.emit(SuccessStateGetEstimation(estimation: LatLng(
          id: estimation.id,
          delay: 10,
        )));
      }
      else {
        this.emit(ErrorStateGetEstimation(message: result.error.toString()));
      }
    }
  }

  Future<Point> _parse({@required String value}) async{
    value = value.replaceAll(',', '');
    List<String> values = value.split(' ');
    if(values.length == 2) {
      if(Validation.latitude(values[0]) && Validation.longitude(values[1])) {
        return Point(lat: double.tryParse(values[0]), lng: double.tryParse(values[1]));
      }
      else{
        this.emit(ErrorStateGetEstimation(message: AppStrings.errorParse));
        return null;
      }
    }
    else {
      this.emit(ErrorStateGetEstimation(message: AppStrings.errorParse));
      return null;
    }
  }
}