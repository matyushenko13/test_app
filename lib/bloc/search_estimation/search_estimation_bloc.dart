import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_checkbox/entities/estimation_history.dart';
import 'package:test_app_checkbox/generated_code/example_swagger.swagger.dart';
import 'package:test_app_checkbox/tools/format.dart';
import 'package:test_app_checkbox/utils/app_strings.dart';

import 'search_estimation_state.dart';

class SearchEstimationBloc extends Cubit<SearchEstimationState> {
  SearchEstimationBloc() : super(ViewStateSearchEstimation());

  void submit({
    @required String index,
  }) async {
    this.emit(WaitingStateSearchEstimation());

    if (index.isNotEmpty) {
      final client = ExampleSwagger.create();

      final result = await client.getEstimation(id: index);

      if (result.isSuccessful) {
        Estimation estimation = Estimation.fromJsonFactory(result.body);
        this.emit(SuccessStateSearchEstimation(
            estimation: LatLng(
          id: estimation.id,
          distance: Format.getDistance(estimation.distance),
          duration: Format.getTime(estimation.duration),
        )));
      } else {
        this.emit(
          ErrorStateSearchEstimation(message: "${result.error.toString()}"),
        );
      }
    } else {
      this.emit(ErrorStateSearchEstimation(message: AppStrings.errorSearch));
    }
  }
}
