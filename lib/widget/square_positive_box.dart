import 'package:cwnumeal/util/device_size.dart';
import 'package:cwnumeal/widget/positive_box.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SquarePositiveBox extends PositiveBox {
  final Widget child;
  final Function() onPressed;
  final double? width;

  SquarePositiveBox({
    Key? key,
    this.width,
    required this.child,
    required this.onPressed,
  }) : super(key: key, onPressed: onPressed);

  @override
  Widget BuildContent() {
    return SizedBox(
      width: width ?? DeviceSize.width * 0.8,
      child: child,
    );
  }

  @override
  NeumorphicBoxShape buildBoxShape() {
    return NeumorphicBoxShape.roundRect(
      BorderRadius.circular(12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}
