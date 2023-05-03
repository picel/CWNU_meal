import 'package:cwnumeal/widget/positive_box.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CirclePositiveBox extends PositiveBox {
  final Widget child;
  final Function() onPressed;

  CirclePositiveBox({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key, onPressed: onPressed);

  @override
  Widget BuildContent() {
    return child;
  }

  @override
  NeumorphicBoxShape buildBoxShape() {
    return NeumorphicBoxShape.circle();
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
