import 'package:expense_tracker_app/data/categories.dart';
import 'package:expense_tracker_app/model/category.dart';
import 'package:expense_tracker_app/model/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _formKey = GlobalKey<FormState>();

  double? _amount;
  Category? _category;
  String? _description;

  void _onSaveExpense() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(Expense(
          amount: _amount!, description: _description!, category: _category!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Amount'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please Enter an amount';
                    }
                    _amount = double.tryParse(value.trim());
                    if (_amount == null || _amount! <= 0) {
                      return 'Please enter a valid amount greater than 0';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _amount = double.tryParse(value!);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixText: '\$',
                  ),
                  keyboardType: TextInputType.number),
              const SizedBox(
                height: 24,
              ),
              DropdownButtonFormField<Category>(
                icon: const Icon(Icons.arrow_drop_down_circle,
                    color: Color(0xff4aee1f8)),
                iconSize: 40,
                hint: Text("Expense made for",
                    style: Theme.of(context).inputDecorationTheme.labelStyle),
                validator: (value) =>
                    value == null ? 'Please Select a category' : null,
                onSaved: (newValue) => _category = newValue,
                items: categories.entries.map((entry) {
                  return DropdownMenuItem<Category>(
                    value: entry.value,
                    child: Text(entry.value.title),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  _category = value;
                }),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter some description';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _description = newValue;
                },
              ),
              const SizedBox(
                height: 28,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            _formKey.currentState!.reset();
                          },
                          child: Text('Reset'))),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: _onSaveExpense, child: Text('Save')))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
