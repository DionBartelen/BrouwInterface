import 'dart:async';

import 'package:brouw/enums/pomp_modes.dart';
import 'package:brouw/enums/temp_modes.dart';
import 'package:brouw/enums/verwarm_modes.dart';
import 'package:brouw/models/brouw_info.dart';
import 'package:brouw/services/http_service.dart';
import 'package:brouw/widgets/generic_dropdown_button.dart';
import 'package:brouw/widgets/rows/custom_widget_row.dart';
import 'package:brouw/widgets/scaffolds/base_padding_scaffold.dart';
import 'package:flutter/material.dart';

class BedieningScreen extends StatefulWidget {
  const BedieningScreen({super.key});

  @override
  _BedieningScreenState createState() => _BedieningScreenState();
}

class _BedieningScreenState extends State<BedieningScreen> {
  StreamSubscription<BrouwInfo>? _subscription;

  // Cleaner would be to move this to the initState, but this will suffice.
  bool tempWortMan =
      HTTPService.getLatestData()?.modes.tempWort == TempModes.HAND;
  bool tempPompMan =
      HTTPService.getLatestData()?.modes.tempPomp == TempModes.HAND;

  double tempWort = HTTPService.getLatestData()?.temperatures.wort ?? 0.0;
  double tempPomp = HTTPService.getLatestData()?.temperatures.pomp ?? 0.0;

  PompModes pompMode =
      HTTPService.getLatestData()?.modes.pompMode ?? PompModes.AUTO;
  VerwarmModes verwarmMode =
      HTTPService.getLatestData()?.modes.verwarmMode ?? VerwarmModes.AUTO;

  TempModes tempWortDropdownValue =
      HTTPService.getLatestData()?.modes.tempWort ?? TempModes.AUTO;
  TempModes tempPompDropdownValue =
      HTTPService.getLatestData()?.modes.tempPomp ?? TempModes.AUTO;

  // Text editing controllers
  late TextEditingController wortController;
  late TextEditingController pompController;

  // Focus nodes, will be used later on to determine if we can update a field.
  late FocusNode wortFocusNode = FocusNode();
  late FocusNode pompFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    wortController = TextEditingController(text: tempWort.toString());
    pompController = TextEditingController(text: tempPomp.toString());

    _subscription = HTTPService.onBrouwInfoReceived.stream.listen((brouwInfo) {
      // We got a new 'snapshot' of the brouw info, update the state.
      setState(() {
        tempWortMan = brouwInfo.modes.tempWort == TempModes.HAND;
        tempPompMan = brouwInfo.modes.tempPomp == TempModes.HAND;
        tempWort = brouwInfo.temperatures.wort;
        tempPomp = brouwInfo.temperatures.pomp;
        pompMode = brouwInfo.modes.pompMode;
        verwarmMode = brouwInfo.modes.verwarmMode;

        // We may only update the text fields if they don't have focus (a.k.a editing)
        if (!wortFocusNode.hasFocus) wortController.text = tempWort.toString();
        if (!pompFocusNode.hasFocus) pompController.text = tempPomp.toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Close the subscription nicely ;)
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
              title: "Pomp mode:",
              widget: GenericDropdownButton(
                value: pompMode,
                values: PompModes.values,
                onChanged: (value) {
                  HTTPService.setPompMode(value);
                  setState(() {
                    pompMode = value;
                  });
                },
              ),
            ),
            CustomWidgetRow(
              title: "Verwarm mode:",
              widget: GenericDropdownButton(
                value: verwarmMode,
                values: VerwarmModes.values,
                onChanged: (value) {
                  HTTPService.setVerwarmMode(value);
                  setState(() {
                    verwarmMode = value;
                  });
                },
              ),
            ),
            CustomWidgetRow(
              title: "Temperatuur wort mode:",
              widget: GenericDropdownButton(
                value: tempWortDropdownValue,
                values: TempModes.values,
                onChanged: (value) {
                  HTTPService.setTempWortMode(value);
                  setState(() {
                    tempWortDropdownValue = value;
                  });
                },
              ),
            ),
            CustomWidgetRow(
              title: "Temperatuur pomp mode:",
              widget: GenericDropdownButton(
                value: tempPompDropdownValue,
                values: TempModes.values,
                onChanged: (value) {
                  HTTPService.setTempPompMode(value);
                  setState(() {
                    tempPompDropdownValue = value;
                  });
                },
              ),
            ),
            CustomWidgetRow(
              title: "Temperatuur wort:",
              widget: SizedBox(
                width: 100.0,
                child: TextFormField(
                  focusNode: wortFocusNode,
                  enabled: tempWortMan,
                  controller: wortController,
                  decoration: const InputDecoration(labelText: ""),
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (value) =>
                      HTTPService.setTempWort(double.parse(value)),
                ),
              ),
            ),
            CustomWidgetRow(
              title: "Temperatuur pomp:",
              widget: SizedBox(
                width: 100.0,
                child: TextFormField(
                  focusNode: pompFocusNode,
                  enabled: tempPompMan,
                  controller: pompController,
                  decoration: const InputDecoration(labelText: ""),
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (value) => HTTPService.setTempPomp(
                    // TODO: Reconsider, as this might not be true (copy pasting may result in a parse error)
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
