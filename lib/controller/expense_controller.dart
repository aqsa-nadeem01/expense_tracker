import 'package:expense_tracker_app/database/db_helper.dart';
import 'package:expense_tracker_app/model/expense.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  RxList<Expense> registratedExpense = <Expense>[].obs;

  Future<void> fetchExpensesFromDb() async {
    final List<Expense> expenses =
        await DatabaseHelper.getExpensesWithCategories();
    registratedExpense.addAll(expenses);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchExpensesFromDb().catchError((e) {
      print(e);
    });
  }

  Future<void> addExpense(Expense expense) async {
    registratedExpense.add(expense); // Add to observable list immediately
    await DatabaseHelper.insertExpense(expense); // Await insertion into the database
  }

  Future<void> removeExpense(Expense expense) async {
    final int expenseIndex = registratedExpense.indexOf(expense);
    registratedExpense.removeAt(expenseIndex);
    await DatabaseHelper.deleteExpense(expense.id!);
  }

  Future<void> updateExpense(int index, Expense updatedExpense) async {
    // Get the original expense from the list
    Expense existingExpense = registratedExpense[index];

    // Create a new Expense object with the same id but updated values
    Expense expenseToUpdate = Expense(
      id: existingExpense.id, // Keep the original id
      amount: updatedExpense.amount, // New amount from the updatedExpense
      description: updatedExpense.description, // New description
      category: updatedExpense.category, // New category
    );

    // Update the list with the newly created expense
    registratedExpense[index] = expenseToUpdate;

    // Pass the newly created expense to the database helper for updating in DB
    await DatabaseHelper.updateExpense(expenseToUpdate);
  }


}
