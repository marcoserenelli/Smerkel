import 'package:flutter/material.dart';
import '../models/transaction.dart';

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
                Padding(
                  //Add transaction button
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: ElevatedButton(
                      onPressed: _submitTransaction,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.purple),
                      ),
                      child: const Text('Add Transaction')),
                ),
                SizedBox(
                  //List of transactions
                  height: 300,
                  width: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                '\$${_transactionsList[index].amount}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_transactionsList[index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                                Text(
                                  '${_transactionsList[index].date.hour}:${_transactionsList[index].date.minute} ${_transactionsList[index].date.day}/${_transactionsList[index].date.month}/${_transactionsList[index].date.year}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

  void _submitTransaction() {
    if (_formKey.currentState!.validate()) {
      Transaction newTransaction = Transaction(
        amount: double.parse(_amountController.text),
        title: _descriptionController.text,
        description: _descriptionController.text,
        date: DateTime.now(),
      );
      setState(() {
        _transactionsList.add(newTransaction);
      });
    }
  }
}
