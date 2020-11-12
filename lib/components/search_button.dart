import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      tooltip: 'Search',
      onPressed: () => Navigator.of(context).pushNamed('/search'),
    );
  }
}