

class Fan {
  final String id;
  final String name;
  bool isOn;
  int speed;

  Fan({
    required this.id,
    required this.name,
    required this.isOn,
    required this.speed,
  });

  factory Fan.fromJson(Map<String, dynamic> json) {
    return Fan(
      id: json['id'],
      name: json['name'],
      isOn: json['power'],
      speed: json['speed'],
    );
  }
}
