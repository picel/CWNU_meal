import 'package:cwnumeal/util/device_size.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NegativeBox extends StatelessWidget {
  final Widget child;
  final double? width;

  NegativeBox({
    Key? key,
    required this.child,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        lightSource: LightSource.topLeft,
        depth: -6,
        // color: Colors.white,
      ),
      child: Container(
        margin: EdgeInsets.all(DeviceSize.height * 0.01),
        padding: EdgeInsets.all(DeviceSize.height * 0.01),
        width: DeviceSize.width * 0.7,
        child: child,
      ),
    );
  }
}
