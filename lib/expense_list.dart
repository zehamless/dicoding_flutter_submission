import 'package:flutter/material.dart';
import 'model/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseIncomeModel> expense;
  const ExpenseList({Key? key, required this.expense}) : super(key: key);

  IconData getIconForTitle(String title) {
    switch (title) {
      case 'F&B':
        return Icons.fastfood;
      case 'Transport':
        return Icons.directions_car;
      case 'Shopping':
        return Icons.shopping_cart;
      case 'Entertainment':
        return Icons.movie;
      case 'Income':
        return Icons.attach_money;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Amount')),
                ],
                rows: expense.map((expense) {
                  return DataRow(cells: [
                    DataCell(Row(
                      children: [
                        Icon(
                          getIconForTitle(expense.title),
                          color: expense.isExpense ? Colors.red : Colors.green,
                        ),
                        const SizedBox(width: 8),
                        Text(expense.title),
                      ],
                    )),
                    DataCell(Text(expense.amount.toString())),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}