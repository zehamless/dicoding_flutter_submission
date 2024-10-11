import 'package:flutter/material.dart';
import 'model/expense.dart';

class DetailListPage extends StatelessWidget {
  final List<ExpenseIncomeModel> items;
  final String title;

  const DetailListPage({Key? key, required this.items, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: Icon(item.isExpense ? Icons.money_off : Icons.attach_money),
            title: Text(item.title),
            subtitle: Text('Rp.${item.amount}'),
          );
        },
      ),
    );
  }
}