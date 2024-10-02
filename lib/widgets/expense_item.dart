import 'package:expense_tracker_app/model/expense.dart';
import 'package:expense_tracker_app/screens/update_expense.dart';
import 'package:expense_tracker_app/controller/expense_controller.dart';
import 'package:expense_tracker_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // Access the ExpenseController instance
    final ExpenseController controller = Get.find<ExpenseController>();

    void onUpdateExpense(int index) async {
      final Expense? updatedExpense = await Navigator.of(context).push<Expense>(
        MaterialPageRoute(
          builder: (ctx) => UpdateExpense(existingExpense: expense),
        ),
      );

      if (updatedExpense != null) {
        controller.updateExpense(index, updatedExpense);
      }
    }

    return SlidableAutoCloseBehavior(
      closeWhenOpened: true,
      child: Slidable(
        key: UniqueKey(),
        closeOnScroll: true,
        endActionPane: ActionPane(
          dismissible: DismissiblePane(onDismissed: () {
            controller.removeExpense(expense);
          }),
          motion: const StretchMotion(),
          extentRatio: 0.5,
          children: [
            SlidableAction(
              onPressed: (context) {

                int index = controller.registratedExpense.indexOf(expense);
                onUpdateExpense(index);
              },
              backgroundColor: Colors.deepPurpleAccent.shade200,
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: (context) {
                controller.removeExpense(expense);
              },
              backgroundColor: Colors.blue,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Card(
          color: Colors.blue.shade50,
          child: Container(
            height: SizeConfig.screenHeight * 0.1,
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFaee1f8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        expense.category.icon,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.category.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          expense.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    '\$ ${expense.amount.toString()}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
