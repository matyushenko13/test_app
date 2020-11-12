import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_checkbox/bloc/history_estimation/history_estimation_bloc.dart';
import 'package:test_app_checkbox/entities/estimation_history.dart';
import 'package:test_app_checkbox/utils/app_strings.dart';

class HistoryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(AppStrings.historyScreen),
        ),
        body: BlocBuilder<HistoryEstimationBloc, List<EstimationHistory>>(
          builder: (context, state) {
            if(state.isEmpty){
              return Padding(
                padding: EdgeInsets.all(16),
                child: Text(AppStrings.errorHistoryIsEmpty),
              );
            }

            return ListView.builder(
              itemCount: state.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed('/search', arguments: state[index]),
                  child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(AppStrings.index + state.elementAt(index).id),
                            ),
                            (state.elementAt(index).duration == null) ? Container() :
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(AppStrings.duration + state.elementAt(index).duration.toString()),
                            ),
                            (state.elementAt(index).distance == null) ? Container() :
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(AppStrings.distance + state.elementAt(index).distance.toString()),
                            ),
                            (state.elementAt(index).delay == null || state.elementAt(index).delay == 0) ? Container() :
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(AppStrings.delay + state.elementAt(index).delay.toString()),
                            ),
                          ])),
                ));
          }));
  }
}