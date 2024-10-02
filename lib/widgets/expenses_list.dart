import 'package:expense_tracker_app/model/expense.dart';
import 'package:expense_tracker_app/screens/update_expense.dart';
import 'package:expense_tracker_app/controller/expense_controller.dart';
import 'package:expense_tracker_app/utils/size_config.dart';
import 'package:expense_tracker_app/widgets/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key});



  @override
  Widget build(BuildContext context) {
    var expenses = Get.find<ExpenseController>().registratedExpense;
    return Obx(() {
      var expenses = Get.find<ExpenseController>().registratedExpense;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        height: SizeConfig.screenHeight * 0.5,
        child: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) => ExpenseItem(expenses[index]),
        ),
      );
    });
  }
}
