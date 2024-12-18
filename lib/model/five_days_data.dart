class FiveDaysData {
  final String? dateTime;
  final int? temp;

  FiveDaysData({this.dateTime, this.temp});

  factory FiveDaysData.fromJson(dynamic json) {
    if (json == null) {
      return FiveDaysData();
    }

    var f = json['dt_txt'].split(' ')[0].split('-')[2];
    var l = json['dt_txt'].split(' ')[1].split(':')[0];
    var fandl = '$f-$l';
    
    final tempKelvin = (json['main']['temp'] as num?)?.toDouble() ?? 273.15;
    final tempCelsius = (tempKelvin - 273.15).round();
    
    return FiveDaysData(
      dateTime: fandl,
      temp: tempCelsius,
    );
  }
}
