import 'package:expense_tracker_app/data/categories.dart';
import 'package:expense_tracker_app/model/category.dart';
import 'package:expense_tracker_app/model/expense.dart';
import 'package:expense_tracker_app/screens/new_expense.dart';
import 'package:expense_tracker_app/controller/expense_controller.dart';
import 'package:expense_tracker_app/utils/size_config.dart';
import 'package:expense_tracker_app/widgets/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final ExpenseController expenseController = Get.put(ExpenseController());

    void addExpense() async {
      final Expense? newExpense = await Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const NewExpense()),
      );
      if (newExpense != null) {
        expenseController.addExpense(newExpense);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker App'),
      ),
      body: Obx(() {
        final expensesList = expenseController.registratedExpense;

        Widget mainContent = expensesList.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/bg.png'),
            SizedBox(
              height: SizeConfig.screenHeight * 0.02,
            ),
            Text(
              "Track Your Expenses",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        )
            : Column(
          children: [
            Chart(),
            Expanded(child: ExpensesList()),
          ],
        );

        return Stack(
          children: [
            mainContent,
            Positioned(
              bottom: SizeConfig.screenHeight * 0.04,
              right: SizeConfig.screenWidth * 0.08,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: addExpense,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        );
      }),
    );
  }
}
