import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_checkbox/bloc/get_estimation/get_estimation_bloc.dart';
import 'package:test_app_checkbox/bloc/get_estimation/get_estimation_state.dart';
import 'package:test_app_checkbox/bloc/history_estimation/history_estimation_bloc.dart';
import 'package:test_app_checkbox/components/custom_text_field.dart';
import 'package:test_app_checkbox/components/error_dialog.dart';
import 'package:test_app_checkbox/components/history_button.dart';
import 'package:test_app_checkbox/components/search_button.dart';
import 'package:test_app_checkbox/utils/app_strings.dart';
import 'package:latlong/latlong.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _fromController;
  TextEditingController _toController;

  FocusNode _toNode;

  GetEstimationBloc _getEstimationBloc;

  @override
  void initState() {
    _getEstimationBloc = GetEstimationBloc();
    _fromController = TextEditingController();
    _toController = TextEditingController();
    _toNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _getEstimationBloc.close();
    _fromController.dispose();
    _toController.dispose();
    _toNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.mainScreen),
        actions: [
          SearchButton(),
          HistoryButton(),
        ]),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  AppStrings.mainScreenText,
                  textAlign: TextAlign.center,
                )),
            Container(
                padding: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.departure,
                )),
            CustomTextField(
              controller: _fromController,
              hintText: AppStrings.hintLatLng,
              textInputAction: TextInputAction.next,
              onPressedIcon: () => Navigator.of(context).pushNamed('/map').then((value) {
                if(value is LatLng){
                  _fromController.text = '${value.latitude.toStringAsFixed(6)}, ${value.longitude.toStringAsFixed(6)}';
                }
              }),
              onSubmitted: (_) => FocusScope.of(context).requestFocus(_toNode),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 8, top: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.arrival,
                )),
            CustomTextField(
              controller: _toController,
              focusNode: _toNode,
              hintText: AppStrings.hintLatLng,
              onPressedIcon: () => Navigator.of(context).pushNamed('/map').then((value) {
                if(value is LatLng){
                  _toController.text = '${value.latitude.toStringAsFixed(6)}, ${value.longitude.toStringAsFixed(6)}';
                }
              }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: BlocConsumer(
                cubit: _getEstimationBloc,
                builder: (context, state){
                  if(state is WaitingStateGetEstimation){
                    return CircularProgressIndicator();
                  }

                  return MaterialButton(
                    child: Text(
                      AppStrings.submit,
                    ),
                    onPressed: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      _getEstimationBloc.submit(from: _fromController.text, to: _toController.text);
                    },
                  );
                },
                listenWhen: (previous, current) => current is SuccessStateGetEstimation || current is ErrorStateGetEstimation ? true : false,
                listener: (context, state){
                  if(state is ErrorStateGetEstimation) {
                    showDialog(
                      context: context,
                      child: ErrorDialog(message: state.message)
                    );
                  }
                  if(state is SuccessStateGetEstimation) {
                    context.read<HistoryEstimationBloc>().update(estimation: state.estimation);
                    Navigator.of(context).pushNamed('/history');
                  }
                },
              ),
            )
          ])));
  }
}