import 'package:flutter/material.dart';

class Modalities {
  String description;
  int duration;
  int id;
  String label;

  Modalities({
    @required this.description,
    @required this.duration,
    @required this.id,
    @required this.label,
  });

  factory Modalities.fromJson(Map<String, dynamic> json) {
    return Modalities(
      description: json["description"] as String,
      duration: json["duration"] as int,
      id: json["id"] as int,
      label: json["label"] as String,
    );
  }

  Map toJson() {
    return {
      "description": this.description,
      "duration": this.duration,
      "id": this.id,
      "label": this.label,
    };
  }
}
