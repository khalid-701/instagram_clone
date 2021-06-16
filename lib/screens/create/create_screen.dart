import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  static const String routeName = '/create';
  const CreateScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Create"),
      ),
    );
  }
}
