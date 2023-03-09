import 'package:flutter/material.dart';
import 'dart:math';
import '../models/transaction.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transactionItem;
  const TransactionCard(this.transactionItem, {super.key});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Transaction transactionItem = widget.transactionItem;

    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0015)
        ..rotateY(pi * _animation.value),
      child: InkWell(
        onTap: () {
          if (_status == AnimationStatus.dismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        child: _animation.value <= 0.5
            ? SizedBox(
                width: 100,
                height: 80,
                child: Card(
                  elevation: 5,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor:
                        transactionItem.amount < 0 ? Colors.red : Colors.green,
                    onTap: () {
                      if (_status == AnimationStatus.dismissed) {
                        _controller.forward();
                      } else {
                        _controller.reverse();
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: transactionItem.amount < 0
                                  ? Colors.red
                                  : Colors.green,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '€ ${transactionItem.amount}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: transactionItem.amount < 0
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(transactionItem.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            Text(
                              '${transactionItem.date.hour}:${transactionItem.date.minute} ${transactionItem.date.day}/${transactionItem.date.month}/${transactionItem.date.year}',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: 100,
                height: 80,
                child: Card(
                  elevation: 5,
                  clipBehavior: Clip.hardEdge,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () => {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              //Remove transaction from list
                            ),
                          ),
                          IconButton(
                            onPressed: () => {},
                            icon: const Icon(
                              Icons.open_in_full,
                              color: Colors.blue,
                            ),
                          ),
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child: IconButton(
                              onPressed: () => {
                                if (_status == AnimationStatus.dismissed)
                                  {_controller.forward()}
                                else
                                  {_controller.reverse()}
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
      ),
    );
  }
}
