import 'package:flutter/material.dart';

class HistoryButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.assignment_outlined),
      tooltip: 'History',
      onPressed: () => Navigator.of(context).pushNamed('/history'),
    );
  }
}