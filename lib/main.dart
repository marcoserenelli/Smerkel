import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './widgets/bottom_navbar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TransactionWidget(),
      ),
    );
  }
}