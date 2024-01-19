import 'dart:async';

import 'package:brouw/enums/brouw_modes.dart';
import 'package:brouw/enums/wacht_modes.dart';
import 'package:brouw/models/brouw_info.dart';
import 'package:brouw/services/http_service.dart';
import 'package:brouw/widgets/generic_dropdown_button.dart';
import 'package:brouw/widgets/rows/custom_widget_row.dart';
import 'package:brouw/widgets/scaffolds/base_padding_scaffold.dart';
import 'package:flutter/material.dart';

class ProcesScreen extends StatefulWidget {
  const ProcesScreen({super.key});

  @override
  _ProcesScreenState createState() => _ProcesScreenState();
}

class _ProcesScreenState extends State<ProcesScreen> {
  StreamSubscription<BrouwInfo>? _subscription;

  BrouwModes brouwValue =
      HTTPService.getLatestData()?.brouwSnapshot.brouwMode ?? BrouwModes.AUTO;
  WachtModes loopWachtValue =
      HTTPService.getLatestData()?.brouwSnapshot.loopWachtMode ??
          WachtModes.ALLES;

  int cyclusTijd = HTTPService.getLatestData()?.brouwSnapshot.cyclusTijd ?? 0;
  int percentageAan =
      HTTPService.getLatestData()?.brouwSnapshot.percentageAan ?? 0;

  // We want to initialize the controllers with the values from the server
  late TextEditingController wortController;
  late TextEditingController pompController;

  // Focus handling so manual values don't get overriden
  FocusNode _wortFocus = FocusNode();
  FocusNode _pompFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    pompController = TextEditingController(text: percentageAan.toString());
    wortController = TextEditingController(text: cyclusTijd.toString());

    _subscription = HTTPService.onBrouwInfoReceived.stream.listen((event) {
      setState(() {
        brouwValue = event.brouwSnapshot.brouwMode;
        loopWachtValue = event.brouwSnapshot.loopWachtMode;
        cyclusTijd = event.brouwSnapshot.cyclusTijd;
        percentageAan = event.brouwSnapshot.percentageAan;

        // Thou shall not be overwriten by the server!
        if (!_wortFocus.hasFocus) wortController.text = cyclusTijd.toString();
        if (!_pompFocus.hasFocus) pompController.text = percentageAan.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BasePaddingScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomWidgetRow(
              title: "Brouw mode:",
              widget: GenericDropdownButton(
                value: brouwValue,
                values: BrouwModes.values,
                onChanged: (mode) {
                  if (mode == null) return;
                  HTTPService.setBrouwMode(mode.value);

                  setState(() {
                    brouwValue = mode;
                  });
                },
              ),
            ),
            CustomWidgetRow(
              title: "Loop-Wacht mode:",
              widget: GenericDropdownButton(
                value: loopWachtValue,
                values: WachtModes.values,
                onChanged: (mode) {
                  if (mode == null) return;
                  HTTPService.setLoopWachtMode(mode.value);

                  setState(() {
                    loopWachtValue = mode;
                  });
                },
              )
            ),
            CustomWidgetRow(
              title: "Cyclustijd wort:",
              widget: SizedBox(
                width: 100.0,
                child: TextFormField(
                  focusNode: _wortFocus,
                  controller: wortController,
                  decoration: const InputDecoration(
                    labelText: "",
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (value) => HTTPService.setCyclusTijd(
                    double.parse(
                      value,
                    ),
                  ),
                ),
              ),
            ),
            CustomWidgetRow(
              title: "Percentage aan pomp:",
              widget: SizedBox(
                width: 100.0,
                child: TextFormField(
                  focusNode: _pompFocus,
                  controller: pompController,
                  decoration: const InputDecoration(
                    labelText: "",
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: false, decimal: true),
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (value) => HTTPService.setPercentageAan(
                    double.parse(
                      value,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
