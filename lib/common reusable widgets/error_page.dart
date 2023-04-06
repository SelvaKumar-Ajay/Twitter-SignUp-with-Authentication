import 'package:flutter/material.dart';

class ErrorLoader extends StatelessWidget {
  final String error;
  const ErrorLoader({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Text(error);
  }
}

class ErrorPage extends StatelessWidget {
  final String error;
  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorLoader(error: error),
    );
  }
}
