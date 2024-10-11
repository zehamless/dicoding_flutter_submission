import 'package:flutter/material.dart';
import 'model/expense.dart';

class AddExpenseForm extends StatefulWidget {
  final Function(ExpenseIncomeModel) onAddExpense;

  const AddExpenseForm({Key? key, required this.onAddExpense})
      : super(key: key);

  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String? _selectedTitle;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newExpense = ExpenseIncomeModel(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _selectedTitle!,
        amount: double.parse(_amountController.text),
        isExpense: _selectedTitle != 'Income',
      );
      widget.onAddExpense(newExpense);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Expense/Income'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedTitle,
              decoration: const InputDecoration(labelText: 'Title'),
              items: const [
                DropdownMenuItem(
                  value: 'F&B',
                  child: Row(
                    children: [
                      Icon(Icons.fastfood),
                      SizedBox(width: 8),
                      Text('F&B'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Transport',
                  child: Row(
                    children: [
                      Icon(Icons.directions_car),
                      SizedBox(width: 8),
                      Text('Transport'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Shopping',
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart),
                      SizedBox(width: 8),
                      Text('Shopping'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Entertainment',
                  child: Row(
                    children: [
                      Icon(Icons.movie),
                      SizedBox(width: 8),
                      Text('Entertainment'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Income',
                  child: Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 8),
                      Text('Income'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedTitle = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
