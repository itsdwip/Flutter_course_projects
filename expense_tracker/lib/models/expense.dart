import "package:expense_tracker/core.dart";
import "package:intl/intl.dart";

const uuid = Uuid();

final formattedIntlDate = DateFormat.yMd();

enum Category {
  loan,
  utilities,
  insurance,
  taxes,
  education,
  food,
  gas,
  rent,
  fees,
  internet,
  transportation,
  fun,
  work,
  entertainment,
}

const Map<Category, IconData> categoryIcons = {
  Category.loan: Icons.money_off,
  Category.utilities: Icons.lightbulb_outline,
  Category.insurance: Icons.security,
  Category.taxes: Icons.money,
  Category.education: Icons.school,
  Category.food: Icons.restaurant,
  Category.gas: Icons.local_gas_station,
  Category.rent: Icons.house,
  Category.fees: Icons.money_off,
  Category.internet: Icons.wifi,
  Category.transportation: Icons.directions_car,
  Category.fun: Icons.party_mode,
  Category.work: Icons.work,
  Category.entertainment: Icons.movie,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.categoryIcons,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  final Map categoryIcons;

  String get formattedDate {
    return formattedIntlDate.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
    required IconData iconData,
  });

  ExpenseBucket.forCategory(
    List<Expense> allExpense,
    this.category,
  ) : expenses = allExpense
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
