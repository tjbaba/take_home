import 'dart:ui';

import 'package:flutter/material.dart';

class Task{
  String? title, description, label, note;
  DateTime? dueDate, startDate;
  Color? color;
  Task({this.title, this.description, this.label,this.note, this.dueDate,this.color, this.startDate});

  factory Task.fromJson(Map<String, dynamic> data) {
    List<dynamic> list = data['tasksList'] ?? [];

    final tasksList = list.map((e) => Task.fromJson(e)).toList();

    return Task(
      title: data['title'],
      description: data['description'],
      label: data['label'],
      note: data['note'],
      dueDate: data['dueDate'],
      startDate: data['startDate'],
      color:data['color'] == null?Colors.white :Color(data['color'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'label': label,
      'note': note,
      'dueDate': dueDate,
      'startDate': startDate,
      'color':color == null?null: color!.value
    };
  }
}