class Weather{
 int? id;
 String? main, description,icon;

 Weather({   this.id,    this.main,    this.description,    this.icon});

 factory Weather.fromJson(Map<String, dynamic> json) {

    return Weather(
      id: json["id"],
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }

 Map<String, dynamic> toJson() {
    return {
      "id": id,
      "main": main,
      "description": description,
      "icon": icon,
    };
  }
}