import 'dart:math';

import 'package:expense_tracker_app/model/category.dart';
import 'dart:core';

final Random random = Random();
class Expense {
  Expense({
    required this.amount,
    required this.description,
    required this.category,
  this.id
  });

  int? id;
  final double amount;
  final Category category;
  final String description;

  // Deserialization from JSON
  Expense.fromJson(Map<String, dynamic> json, Category category)
      : id = json['id'],  // Assign the id from JSON
        amount = json['amount'],  // Assign the amount
        description = json['description'],  // Assign the description
        category = category;  // Assign the full Category object

  // Serialization to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'category_id': category.id,  // Only store category_id in the expense table
    };
  }
}
