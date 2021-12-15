import 'package:flutter/material.dart';

class Remedio {
  String title;
  String time;
  String next;
  String initial_time;
  String dosage;
  int interval;
  int duration;
  String type;
  bool lat;

  Remedio(this.title, this.time, this.next, this.initial_time, this.dosage,
      this.interval, this.duration, this.type,
      {this.lat = false});

  Remedio.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    time = json['time'];
    next = json['next'];
    initial_time = json['initial_time'].toString();
    dosage = json['dosage'];
    interval = json['interval'];
    duration = json['duration'];
    type = json['type'];
    lat = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['time'] = this.time;
    data['next'] = this.next;
    data['initial_time'] = this.initial_time.toString();
    data['dosage'] = this.dosage;
    data['interval'] = this.interval;
    data['duration'] = this.duration;
    data['type'] = this.type;
    lat = false;

    return data;
  }
}
