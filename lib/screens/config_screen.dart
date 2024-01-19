import 'package:brouw/widgets/scaffolds/base_padding_scaffold.dart';
import 'package:flutter/material.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BasePaddingScaffold(
      body: Text(
        "Config screen",
      ),
    );
  }
}
