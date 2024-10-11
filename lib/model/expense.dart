class ExpenseIncomeModel {
  int id;
  String title;
  double amount;
  bool isExpense;

  ExpenseIncomeModel(
      {required this.id,
      required this.title,
      required this.amount,
      this.isExpense = true
    });
}


