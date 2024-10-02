import 'dart:convert';
import 'package:flutter/material.dart';

enum ExpenseCategory {
  food,
  transportation,
  entertainment,
  health,
  utilities,
  education,
  shopping,
  travel,
  others,
}

class Category {
  Category(this.title, this.icon, this.color, {this.id});
  String title;
  IconData icon;
  Color color;
  int? id;

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        title = json['title'] as String,
        icon = IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),  // Directly cast icon to int
        color = Color(json['color'] as int);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> categoryData = <String, dynamic>{};
    categoryData['id'] = id;
    categoryData['title'] = title;
    categoryData['icon'] = icon.codePoint;  // Use the codePoint to serialize icon
    categoryData['color'] = color.value;
    return categoryData;
  }
}
