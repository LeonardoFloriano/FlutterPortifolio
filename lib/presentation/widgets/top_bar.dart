import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Expanded(child: Text('Leonardo´s Portifolio'))],
        ));
  }
}
