import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app_checkbox/bloc/history_estimation/history_estimation_bloc.dart';
import 'package:test_app_checkbox/bloc/search_estimation/search_estimation_bloc.dart';
import 'package:test_app_checkbox/bloc/search_estimation/search_estimation_state.dart';
import 'package:test_app_checkbox/components/custom_text_field.dart';
import 'package:test_app_checkbox/components/error_dialog.dart';
import 'package:test_app_checkbox/components/history_button.dart';
import 'package:test_app_checkbox/components/search_button.dart';
import 'package:test_app_checkbox/entities/estimation_history.dart';
import 'package:test_app_checkbox/generated_code/example_swagger.swagger.dart';
import 'package:test_app_checkbox/utils/app_strings.dart';

class SearchEstimationScreen extends StatefulWidget{
  final EstimationHistory estimation;
  SearchEstimationScreen({this.estimation});

  @override
  State<StatefulWidget> createState() => SearchEstimationScreenState();
}
class SearchEstimationScreenState extends State<SearchEstimationScreen>{
  TextEditingController _indexController;


  @override
  void initState() {
    _indexController = TextEditingController(text: widget.estimation?.id ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _indexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(AppStrings.searchScreen),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        AppStrings.searchScreenText,
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      padding: EdgeInsets.only(bottom: 8),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.index,
                      )),
                  CustomTextField(
                    controller: _indexController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: BlocConsumer<SearchEstimationBloc, SearchEstimationState>(
                      builder: (context, state) {
                        if(state is WaitingStateSearchEstimation){
                          return CircularProgressIndicator();
                        }

                        return MaterialButton(
                          child: Text(
                            AppStrings.submit,
                          ),
                          onPressed: () => context.read<SearchEstimationBloc>().submit(index: _indexController.text),
                        );
                      },
                      listenWhen: (previous, current) => current is SuccessStateSearchEstimation || current is ErrorStateSearchEstimation ? true : false,
                      listener: (context, state) {
                        if(state is ErrorStateSearchEstimation) {
                          showDialog(
                              context: context,
                              child: ErrorDialog(message: state.message)
                          );
                        }
                        if(state is SuccessStateSearchEstimation) {
                          context.read<HistoryEstimationBloc>().update(estimation: state.estimation);
                          Navigator.of(context).pushNamed('/history');
                        }
                      },
                    ),
                  )
                ])));
  }
}