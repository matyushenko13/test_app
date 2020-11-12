import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_checkbox/entities/estimation_history.dart';
import 'package:test_app_checkbox/generated_code/example_swagger.swagger.dart';
import 'package:test_app_checkbox/tools/format.dart';


class HistoryEstimationBloc extends Cubit<List<EstimationHistory>>{
  HistoryEstimationBloc() : super(List());

  void update({
  @required EstimationHistory estimation,
  }) async {
    if(estimation != null) {
      int index = state.indexWhere((element) => element.id == estimation.id && (element.distance != estimation.distance || element.duration != estimation.duration));
      if(index != -1){
        state.elementAt(index).distance = estimation.distance;
        state.elementAt(index).duration = estimation.duration;
      }
      else{
        state.insert(0, estimation);
      }
      this.emit(List.generate(state.length, (index) => state.elementAt(index)));
      if(estimation.delay != null && estimation.delay > 0) {
        if(index != -1){
          _timer(state.elementAt(index));
        }
        else{
          _timer(state.first);
        }
      }
    }
  }

  void _timer(EstimationHistory estimation){
    Timer.periodic(Duration(seconds: 1), (timer) {
      estimation.delay -= 1;
      this.emit(List.generate(state.length, (index) => state.elementAt(index)));
      if(estimation.delay == 0){
        timer.cancel();
        _getEstimation(estimation);
      }
    });
  }

  void _getEstimation(EstimationHistory estimation) async{
    final client = ExampleSwagger.create();

    final result = await client.getEstimation(id: estimation.id);

    if (result.isSuccessful) {
      Estimation estimation = Estimation.fromJsonFactory(result.body);
      update(estimation: EstimationHistory(
        id: estimation.id,
        distance: Format.getDistance(estimation.distance),
        duration: Format.getTime(estimation.duration),
      ));
    }
    else {
      estimation.delay = 10;
      _timer(estimation);
    }
  }
}