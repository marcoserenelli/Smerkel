import 'package:flutter/material.dart';
import '../models/transaction.dart';

import './transaction_card.dart';

class TransactionWidget extends StatefulWidget {
  const TransactionWidget({super.key});

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  late final List<Transaction> _transactionsList = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        //Input amount
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          autocorrect: false,
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter amount';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Amount',
                            hintText: 'Input amount',
                          ),
                          onChanged: (text) =>
                              setState(() => _amountController.text),
                        ),
                      ),
                      Padding(
                        //Input Title
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter a title' : null,
                            controller: _titleController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Title',
                              hintText: 'Input title',
                            ),
                            onChanged: (text) =>
                                setState(() => _titleController.text)),
                      ),
                      Padding(
                        //Input description
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter Title' : null,
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Description',
                              hintText: 'Input description',
                            ),
                            onChanged: (text) =>
                                setState(() => _descriptionController.text)),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      //Add transaction Minus
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: ElevatedButton(
                          onPressed: () => _submitTransaction(-1),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          child: const Text('-')),
                    ),
                    Padding(
                      //Add transaction Plus
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: ElevatedButton(
                          onPressed: () => _submitTransaction(1),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          child: const Text('+')),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(
                  //List of transactions
                  height: 300,
                  width: 300,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return TransactionCard(
                        _transactionsList[index],
                        transactionRemoveCallback: (Transaction transaction) {
                          setState(() {
                            _transactionsList.remove(transaction);
                          });
                        },
                      );
                    },
                    itemCount: _transactionsList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitTransaction(int sign) {
    if (_formKey.currentState!.validate()) {
      Transaction newTransaction = Transaction(
        amount: double.parse(_amountController.text) * sign,
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateTime.now(),
      );
      setState(() {
        _transactionsList.insert(0, newTransaction);
      });
    }
  }
}
