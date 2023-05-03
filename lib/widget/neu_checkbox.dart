import 'package:cwnumeal/util/device_size.dart';
import 'package:cwnumeal/widget/jua_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuCheckBox extends StatefulWidget {
  final String title;
  final bool value;
  final Function(int) onChanged;

  const NeuCheckBox(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.title})
      : super(key: key);

  @override
  State<NeuCheckBox> createState() => _NeuCheckBoxState();
}

class _NeuCheckBoxState extends State<NeuCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        JuaText(
          text: widget.title,
          fontSize: DeviceSize.height * 0.025,
          bold: false,
          color: NeumorphicTheme.accentColor(context),
        ),
        NeumorphicCheckbox(
          margin: EdgeInsets.symmetric(vertical: DeviceSize.height * 0.01),
          value: widget.value,
          onChanged: (value) {
            widget.onChanged(value! ? 1 : 0);
          },
        ),
      ],
    );
  }
}
