import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'model/expense.dart';

class ExpenseDonutChart extends StatelessWidget {
  final List<ExpenseIncomeModel> expenses;

  const ExpenseDonutChart({Key? key, required this.expenses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: PieChart(
              PieChartData(
                sections: _createPieChartSections(),
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildLegend(),
        ],
      ),
    );
  }

  List<PieChartSectionData> _createPieChartSections() {
    final groupedExpenses = _groupExpensesByTitle();
    final totalAmount = groupedExpenses.values.fold<double>(0, (sum, e) => sum + e);

    return groupedExpenses.entries.map((entry) {
      final percentage = (entry.value / totalAmount) * 100;
      return PieChartSectionData(
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        color: _getColor(entry.key),
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  Map<String, double> _groupExpensesByTitle() {
    final Map<String, double> groupedExpenses = {};
    for (var expense in expenses) {
      if (groupedExpenses.containsKey(expense.title)) {
        groupedExpenses[expense.title] = groupedExpenses[expense.title]! + expense.amount;
      } else {
        groupedExpenses[expense.title] = expense.amount;
      }
    }
    return groupedExpenses;
  }

  Color _getColor(String title) {
    switch (title) {
      case 'F&B':
        return Colors.blue;
      case 'Transport':
        return Colors.green;
      case 'Shopping':
        return Colors.red;
      case 'Entertainment':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Widget _buildLegend() {
    final groupedExpenses = _groupExpensesByTitle();
    return Column(
      children: groupedExpenses.keys.map((title) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 16,
              height: 16,
              color: _getColor(title),
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        );
      }).toList(),
    );
  }
}