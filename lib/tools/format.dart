class Format{
  static String getDistance(double distance){
    String stringDistanse = '';
    if(distance >= 1000){
      double distanceKm = distance / 1000;
      distance -= distanceKm;
      stringDistanse += '${distanceKm.toInt()} km ';
    }
    if(distance > 0){
      stringDistanse += '${distance.toInt()} m';
    }

    return stringDistanse;
  }

  static String getTime(double time){
    String stringTime = '';
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time.toInt() * 1000);
    if(dateTime.hour > 0){
      stringTime += '${dateTime.hour} h ';
    }
    if(dateTime.minute > 0){
      stringTime += '${dateTime.minute} m ';
    }
    if(dateTime.second > 0){
      stringTime += '${dateTime.second} s';
    }
    return stringTime;
  }
}