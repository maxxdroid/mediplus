class Medication {
  String name;
  String type;
  String image;
  String description;
  String id;

  Medication(
      {required this.name,
      required this.description,
      required this.image,
      required this.id,
      required this.type});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
        name: json['name'],
        type: json['type'],
        image: json['image'],
        id: json['id'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'image': image,
      'id' : id
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Medication &&
        other.name == name &&
        other.type == type &&
        other.image == image &&
        other.description == description &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        image.hashCode ^
        description.hashCode ^
        id.hashCode;
  }
}
