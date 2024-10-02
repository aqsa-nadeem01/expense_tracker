import 'package:expense_tracker_app/model/category.dart';
import 'package:expense_tracker_app/model/expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? db;

  // Singleton initialization
  static Future<Database> initDatabase() async {
    if (db != null) return db!;

    final dbDir = await getDatabasesPath();
    final dbPath = join(dbDir, 'expense.db');

    db = await openDatabase(dbPath, version: 3, onCreate: (db, version) async {
      print('Creating tables...');
      await db.execute('''
      CREATE TABLE category(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        icon INTEGER,
        color INTEGER
      )
    ''');

      await db.execute('''
      CREATE TABLE expenses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL,
        description TEXT,
        category_id INTEGER,
        FOREIGN KEY (category_id) REFERENCES category (id)
      )
    ''');

      print('Tables created');
    });

    print('Database initialized');
    return db!;
  }

  // Helper to insert or fetch a category
  static Future<int> _getCategoryId(Category category) async {
    final List<Map<String, dynamic>> existingCategory = await db!.query(
      'category',
      where: 'title = ?',
      whereArgs: [category.title],
    );

    if (existingCategory.isEmpty) {
      // Insert category if it doesn't exist
      return await db!.insert('category', category.toJson());
    } else {
      // Return existing category id
      return existingCategory.first['id'];
    }
  }

  static Future<Map<int, Category>> fetchAllCategories() async {

    final List<Map<String, dynamic>> categoryMaps = await db!.query('category');
    print(categoryMaps);
    return {
      for (var category in categoryMaps)
        category['id']: Category.fromJson(category)
    };
  }

  static Future<List<Expense>> getExpensesWithCategories() async {

    final Map<int, Category> categoryMap = await fetchAllCategories();
    final List<Map<String, dynamic>> expenseMaps = await db!.query('expenses');
    print(expenseMaps);

    return expenseMaps.map((expenseMap) {
      final int categoryId = expenseMap['category_id'];
      final Category category = categoryMap[categoryId]!;
      return Expense.fromJson(expenseMap, category);
    }).toList();
  }

  static Future<void> insertExpense(Expense expense) async {
    try {

      final int categoryId = await _getCategoryId(expense.category);

      await db!.insert('expenses', {
        'amount': expense.amount,
        'description': expense.description,
        'category_id': categoryId,  // Use the categoryId from the database
      });
      print('Expense inserted successfully.');
    } catch (e) {
      print("Error inserting expense: $e");
    }
  }

  static Future<void> deleteExpense(int expenseId) async {
    try {
      await db!.delete(
        'expenses',
        where: 'id = ?',
        whereArgs: [expenseId],
      );
      print('Expense with id $expenseId deleted successfully.');
    } catch (e) {
      print('Error deleting expense: $e');
    }
  }

  static Future<void> updateExpense(Expense expense) async {
    try {
      final int categoryId = await _getCategoryId(expense.category);

      await db!.update(
        'expenses',
        {
          'amount': expense.amount,
          'description': expense.description,
          'category_id': categoryId,
        },
        where: 'id = ?',
        whereArgs: [expense.id],  // Use the expense id for the update
      );
      print('Expense with id ${expense.id} updated successfully.');
    } catch (e) {
      print("Error updating expense: $e");
    }
  }
}
