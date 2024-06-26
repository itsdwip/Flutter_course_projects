import "package:expense_tracker/components/chart.dart";
import "package:expense_tracker/core.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Expense> _registeredExpenses = [];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled:
          MediaQuery.of(context).size.width < 600 ? false : true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          onAddExpense: _addExpense,
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(
      () {
        _registeredExpenses.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Durations.extralong4,
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text('No expenses found. Start adding some!'),
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = Expanded(
        child: ExpenseList(
          expenses: _registeredExpenses,
          onRemoveExpense: _removeExpense,
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'EXPENSE TRACKER',
        ),
        centerTitle: true,
      ),
      body: width < 600
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chart(expenses: _registeredExpenses),
                mainContent,
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                mainContent,
              ],
            ),
    );
  }
}
