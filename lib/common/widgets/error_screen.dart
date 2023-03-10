import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final error;
  const ErrorScreen({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error.toString()),
    );
  }
}
