import 'package:flutter/material.dart';

class GenericDropdownButton extends StatefulWidget {
  const GenericDropdownButton({
    super.key,
    required this.values,
    required this.value,
    required this.onChanged,
  });

  final List<dynamic> values;
  final dynamic value;
  final Function(dynamic) onChanged;

  @override
  State<GenericDropdownButton> createState() => _GenericDropdownButtonState();
}

class _GenericDropdownButtonState extends State<GenericDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.0,
      child: DropdownButton(
        isExpanded: true,
        value: widget.value,
        icon: const Icon(Icons.arrow_drop_down_sharp),
        elevation: 16,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        items: widget.values.map<DropdownMenuItem>(
          (mode) {
            return DropdownMenuItem(
              value: mode,
              child: Text(
                mode.makeReadable(),
              ),
            );
          },
        ).toList(),
        onChanged: widget.onChanged,
      ),
    );
  }
}
