import 'package:flutter_neumorphic/flutter_neumorphic.dart';

abstract class PositiveBox extends StatelessWidget {
  final Function() onPressed;

  PositiveBox({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  Widget BuildContent();
  NeumorphicBoxShape buildBoxShape();

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onPressed,
      style: NeumorphicStyle(
        boxShape: buildBoxShape(),
        lightSource: LightSource.topLeft,
        depth: 6,
        // color: Colors.white,
      ),
      child: BuildContent(),
    );
  }
}
