class Clouds{
  int? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json["all"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "all": all,
    };
  }
}