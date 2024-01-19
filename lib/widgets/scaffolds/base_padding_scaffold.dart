import 'package:flutter/material.dart';

class BasePaddingScaffold extends StatelessWidget {
  const BasePaddingScaffold({super.key, required this.body});

  final Widget body;

  // Let the padding be the same everywhere
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        child: body,
      ),
    );
  }
}
