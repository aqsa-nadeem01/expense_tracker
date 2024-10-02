import 'package:expense_tracker_app/data/categories.dart';
import 'package:expense_tracker_app/model/category.dart';
import 'package:expense_tracker_app/model/expense.dart';
import 'package:flutter/material.dart';

class UpdateExpense extends StatefulWidget {
  const UpdateExpense({required this.existingExpense, super.key});
  final Expense existingExpense;
  @override
  State<StatefulWidget> createState() {
    return _UpdateExpense();
  }
}

class _UpdateExpense extends State<UpdateExpense> {
  final _formKey = GlobalKey<FormState>();

  double? _amount;
  Category? _category;
  String? _description;

  @override
  void initState() {
    super.initState();
    _amount = widget.existingExpense.amount;
    _category = widget.existingExpense.category;
    _description = widget.existingExpense.description;
  }

  void _onUpdateExpense() {
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
        title: const Text("Update Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  initialValue: _amount.toString(),
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


          icon: const Icon(
            Icons.arrow_drop_down_circle,
            color: Color(0xff4aee1f8),
          ),
          iconSize: 40,
          hint: Text(
            "Expense made for",
            style: Theme.of(context).inputDecorationTheme.labelStyle,
          ),
          validator: (value) {
            if (value == null) {
              return 'Please Select a category';
            }
            return null;
          },
          onSaved: (newValue) {
            _category = newValue;
          },
          items: [
            for (final category in categories.entries)
              DropdownMenuItem(
                value: category.value,
                child: Text(category.value.title),
              )
          ],
          onChanged: (newValue) {
            setState(() {
              _category = newValue;
            });
          },
        ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                initialValue: _description,
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
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'))),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: _onUpdateExpense, child: const Text('Update')))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
