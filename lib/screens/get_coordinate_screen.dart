import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:test_app_checkbox/bloc/get_position/get_position_bloc.dart';
import 'package:test_app_checkbox/components/error_dialog.dart';
import 'package:test_app_checkbox/utils/app_strings.dart';

class GetCoordinateScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => GetCoordinateScreenState();
}

class GetCoordinateScreenState extends State<GetCoordinateScreen> with TickerProviderStateMixin {
  MapController _mapController;

  GetPositionBloc _getPositionBloc;

  @override
  void initState() {
    _mapController = MapController();
    _getPositionBloc = GetPositionBloc()..getPosition();
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocConsumer(
        cubit: _getPositionBloc,
        listener: (context, state){
          if(state == null){
            Navigator.of(context).pop();
            showDialog(
                context: context,
                child: ErrorDialog(message: AppStrings.errorPermission)
            );
          }
        },
        builder: (context, state){
          if(state is LatLng){
            if(state.longitude == 0 && state.latitude == 0){
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }

            return Stack(
                children: [
                  FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        center: state,
                        zoom: 13.0,
                      ),
                      layers: [
                        TileLayerOptions(
                            urlTemplate: "http://tiles.maps.sputnik.ru/{z}/{x}/{y}.png",
                            additionalOptions: {
                              'accessToken': '<PUT_ACCESS_TOKEN_HERE>',
                              'id': 'mapbox.streets',
                            }
                        ),
                        MarkerLayerOptions(
                            markers: [
                              Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: state,
                                  builder: (ctx) => Container(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.blue,
                                      ))),
                            ]),
                      ]),
                  Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add,
                        color: Colors.blue,
                        size: 40,
                      )),
                  SafeArea(
                      child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.all(16),
                              child: Icon(
                                Icons.arrow_back_outlined,
                                size: 40,
                              )))),
                ]);
          }

          return Container();
        },
      ),
      floatingActionButton: BlocBuilder(
        cubit: _getPositionBloc,
        builder: (context, state) {
          if(state.longitude != 0 && state.latitude != 0){
            return FloatingActionButton(
              onPressed: () => Navigator.of(context).pop(_mapController.center),
              child: Icon(Icons.check_outlined),
              backgroundColor: Colors.blue,
            );
          }
          return Container();
        },
      ),
    );
  }
}