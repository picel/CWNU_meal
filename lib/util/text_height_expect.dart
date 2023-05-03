import 'package:cwnumeal/util/device_size.dart';
import 'package:flutter/rendering.dart';

class TextHeightExpect {
  double textHeight(List texts, double fontSize, bool bold) {
    List<String> textList = [];
    for (var submodel in texts) {
      textList.add(submodel.content + submodel.title);
    }
    String maxLengthText = _getMaxLengthText(textList);
    return _textSize(maxLengthText, bold, fontSize);
  }

  double _textSize(String text, bool bold, double fontSize) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: DeviceSize.width);
    return textPainter.size.height + DeviceSize.height * 0.1;
  }

  String _getMaxLengthText(List<String> testList) {
    String maxLengthText = "";
    for (String text in testList) {
      if (text.length > maxLengthText.length) {
        maxLengthText = text;
      }
    }
    return maxLengthText;
  }
}
