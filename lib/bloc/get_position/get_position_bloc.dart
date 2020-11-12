import 'dart:io';

import 'package:background_location/background_location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class GetPositionBloc extends Cubit<LatLng>{
  GetPositionBloc() : super(LatLng(0, 0));

  void getPosition() async {
    if (Platform.isIOS) {
      try {
        Location location = Location();
        LocationData userLocation = await location.getLocation();
        this.emit(LatLng(userLocation.latitude, userLocation.longitude));
      }catch(_){
        this.emit(null);
      }
    }

    if (Platform.isAndroid) {
      BackgroundLocation.getPermissions(
        onGranted: () {
          BackgroundLocation.startLocationService();
          BackgroundLocation.getLocationUpdates((location) async {
            BackgroundLocation.stopLocationService();
            this.emit(LatLng(location.latitude, location.longitude));
          });
        },
        onDenied: () {
          this.emit(null);
        },
      );
    }

  }
}