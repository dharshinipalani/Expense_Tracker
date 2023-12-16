
import 'package:expense_tracker/widgets/NewExpense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
        title: 'dart course',
        amount: 20.12,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Biryani',
        amount: 220.12,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'fun mall',
        amount: 40.12,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted!!'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddButtonLayer() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget maincontent = const Center(
      child: Text('No expense found!!'),
    );
    if (_registeredExpense.isNotEmpty) {
      maincontent = ExpensesList(
        expenses: _registeredExpense,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker!"),
        actions: [
          IconButton(
              onPressed: _openAddButtonLayer, icon: const Icon(Icons.add)),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpense),
                Expanded(child: maincontent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpense)),
                Expanded(child: maincontent),
              ],
            ),
    );
  }
}
