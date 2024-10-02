
import 'package:expense_tracker_app/model/category.dart';
import 'package:flutter/material.dart';

Map categories={
  ExpenseCategory.food: Category('Food', Icons.fastfood_outlined, const Color(
      0xff1976d4)),
  ExpenseCategory.transportation: Category('Transportation', Icons.directions_car_outlined, const Color(
      0xff83b0f4)),
  ExpenseCategory.entertainment: Category('Entertainment', Icons.movie_outlined, const Color(
      0xff5da5f4)),
  ExpenseCategory.health: Category('Health', Icons.local_hospital_outlined, const Color(0xFF629fcc)),
  ExpenseCategory.utilities: Category('Utilities', Icons.lightbulb_outline, const Color(
      0xff538af4)),
  ExpenseCategory.education: Category('Education', Icons.school_outlined, const Color(0xFF89c2e8)),
  ExpenseCategory.shopping: Category('Shopping', Icons.shopping_cart_outlined, const Color(
      0xff267697)),
  ExpenseCategory.travel: Category('Travel', Icons.flight_outlined, const Color(
      0xFF288FE3)),
  ExpenseCategory.others: Category('Others', Icons.category_outlined, const Color(0xFF0260d9)),
};