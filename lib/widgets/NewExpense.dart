import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/Models/expense.dart';
import 'package:expense_tracker/widgets/Expenses.dart';
import 'dart:io';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final date = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = date;
    });
  }
  void _showDailog(){
    if(Platform.isIOS) {
      showCupertinoDialog(context: context, builder: (ctx) {
        return CupertinoAlertDialog(
          title: const Text('Invalid Values'),
          content: const Text(
              'Please make sure that you have enter valid title, amount , date and category .'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('ok'))
          ],
        );
      });
    }
    else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Invalid Values'),
              content: const Text(
                  'Please make sure that you have enter valid title, amount , date and category .'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('ok'))
              ],
            );
          });
    }
  }

  void _ValidatingExpense() {
    final amountSelected = double.tryParse(_amountController.text);
    final amountValid = amountSelected == null || amountSelected <= 0;
    if (_titlecontroller.text.trim().isEmpty ||
        amountValid ||
        _selectedDate == null) {
      //error
      _showDailog();
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titlecontroller.text,
          amount: amountSelected,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final  keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return  LayoutBuilder(builder: (ctx,constraints){
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        // width: double.infinity,
        child: SingleChildScrollView(
          child : Padding(
            padding:  EdgeInsets.fromLTRB(16, 48 , 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600 )
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Expanded(
                           child: TextField(
                             controller: _titlecontroller,
                             maxLength: 50,
                             decoration: const InputDecoration(
                               label: Text('title'),
                             ),
                           ),
                       ),
                       const SizedBox(width: 24),
                       Expanded(
                         child: TextField(
                           controller: _amountController,
                           keyboardType: TextInputType.number,
                           decoration: const InputDecoration(
                             prefixText: '\$ ',
                             label: Text('amount'),
                           ),
                         ),
                       )

                     ],
                   )
                else
                TextField(
                  controller: _titlecontroller,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('title'),
                  ),
                ),
                if(width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      Text(_selectedDate == null
                          ? 'no selected date'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                        onPressed: _showDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      )
                    ],
                  )
                else
                    Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('amount'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? 'no selected date'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: _showDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   if(width >= 600)
                     Row(
                       children: [
                         const Spacer(),
                         TextButton(
                           onPressed: () {
                             Navigator.pop(context);
                           },
                           child: const Text('cancel'),
                         ),
                         ElevatedButton(
                           onPressed: _ValidatingExpense,
                           child: const Text('Save'),
                         ),
                       ],
                     )
                    else
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _ValidatingExpense,
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
