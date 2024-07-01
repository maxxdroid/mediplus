class Medicine {
  String name;
  String prescription;
  String image;
  String quantity;
  String usage;
  String time;
  String duration;

  Medicine(
      {required this.name,
      required this.quantity,
      required this.image,
      required this.prescription,
      required this.usage,
      required this.time,
      required this.duration});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
        name: json['name'],
        prescription: json['prescription'],
        image: json['image'],
        quantity: json['quantity'],
        usage: json['usage'],
        duration: json['duration'],
        time: json['time']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'prescription': prescription,
      'quantity': quantity,
      'image' : image,
      'usage': usage,
      'time': time,
      "duration": duration
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Medicine &&
        other.name == name &&
        other.prescription == prescription &&
        other.image == image &&
        other.quantity == quantity &&
        other.usage == usage &&
        other.time == time &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        prescription.hashCode ^
        image.hashCode^
        quantity.hashCode ^
        usage.hashCode ^
        time.hashCode ^
        duration.hashCode;
  }
}
