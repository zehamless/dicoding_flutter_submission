import 'package:flutter/material.dart';
import 'add_expense.dart';
import 'expense_list.dart';
import 'expense_chart.dart';
import 'model/expense.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ExpenseIncomeModel> allItems = [
    ExpenseIncomeModel(id: 1, title: 'F&B', amount: 100000, isExpense: true),
    ExpenseIncomeModel(id: 2, title: 'Transport', amount: 50000, isExpense: true),
    ExpenseIncomeModel(id: 3, title: 'Shopping', amount: 200000, isExpense: true),
    ExpenseIncomeModel(id: 4, title: 'Income', amount: 1000000, isExpense: false),
  ];

  List<ExpenseIncomeModel> get expenses => allItems.where((item) => item.isExpense).toList();
  List<ExpenseIncomeModel> get incomes => allItems.where((item) => !item.isExpense).toList();

  void _addExpense(ExpenseIncomeModel expense) {
    setState(() {
      allItems.add(expense);
    });
  }

  void _navigateToDetailListPage(List<ExpenseIncomeModel> items, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailListPage(items: items, title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var totalIncome = incomes.fold<double>(0, (sum, e) => sum + e.amount);
    var totalExpenses = expenses.fold<double>(0, (sum, e) => sum + e.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Damn, Im Broke'),
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Column(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      child: ExpenseDonutChart(expenses: expenses),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Card(
                            child: ListTile(
                              title: const Text('Total Income'),
                              subtitle: Text('Rp.$totalIncome'),
                              onTap: () => _navigateToDetailListPage(incomes, 'Income List'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            child: ListTile(
                              title: const Text('Remaining Balance'),
                              subtitle: Text('Rp.${totalIncome - totalExpenses}'),
                              onTap: () => _navigateToDetailListPage(expenses, 'Expense List'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            child: ListTile(
                              title: const Text('Total Expenses'),
                              subtitle: Text('Rp.$totalExpenses'),
                              onTap: () => _navigateToDetailListPage(expenses, 'Expense List'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: ExpenseList(
                      expense: allItems,
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      child: ExpenseDonutChart(expenses: expenses),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          child: ListTile(
                            title: const Text('Total Income'),
                            subtitle: Text('Rp.$totalIncome'),
                            onTap: () => _navigateToDetailListPage(incomes, 'Income List'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text('Remaining Balance'),
                            subtitle: Text('Rp.${totalIncome - totalExpenses}'),
                            onTap: () => _navigateToDetailListPage(expenses, 'Expense List'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text('Total Expenses'),
                            subtitle: Text('Rp.$totalExpenses'),
                            onTap: () => _navigateToDetailListPage(expenses, 'Expense List'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ExpenseList(
                      expense: allItems,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddExpenseForm(onAddExpense: _addExpense);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}