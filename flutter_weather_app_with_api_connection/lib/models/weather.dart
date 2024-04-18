class Weather {
  Weather({
    required this.date,
    required this.time,
    required this.state,
    required this.maxTemp,
    required this.minTemp,
    required this.temp,
    required this.wind,
    required this.humidity,
    required this.pressure,
  });

  final DateTime date;
  final DateTime time;
  final String state;
  final int minTemp;
  final int maxTemp;
  final num temp;
  final num wind;
  final num humidity;
  final num pressure;

  factory Weather.fromJson(Map<String, dynamic> source) {
    // this variable contains date and time values
    // for comparing weather objects the date and time values need to be separated
    DateTime unSortedDateAndTime = DateTime.parse(source["dt_txt"]);

    DateTime date = DateTime(
      unSortedDateAndTime.year,
      unSortedDateAndTime.month,
      unSortedDateAndTime.day,
    );

    DateTime time =
        DateTime(0, 0, 0, unSortedDateAndTime.hour, unSortedDateAndTime.minute);

    return Weather(
      date: date,
      time: time,
      state: source["weather"][0]["main"],
      temp: source["main"]["temp"],
      maxTemp: (source["main"]["temp_max"] as double).toInt(),
      minTemp: (source["main"]["temp_min"] as double).toInt(),
      wind: source["wind"]["speed"],
      humidity: source["main"]["humidity"],
      pressure: source["main"]["pressure"],
    );
  }

// used to remove duplicated weather by sets
  @override
  bool operator ==(other) {
    if (other is Weather) {
      if (date.compareTo(other.date) == 0) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  int get hashCode => date.hashCode;
}
