import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuDisplaySwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const NeuDisplaySwitch(
      {Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  State<NeuDisplaySwitch> createState() => _NeuDisplaySwitchState();
}

class _NeuDisplaySwitchState extends State<NeuDisplaySwitch> {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.stadium(),
        lightSource: LightSource.topLeft,
        depth: -5,
        // color: Colors.white,
      ),
      child: SizedBox(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: 90,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.value
                ? NeumorphicTheme.accentColor(context)
                : Colors.transparent,
          ),
          child: InkWell(
            onTap: () {
              widget.onChanged(!widget.value);
            },
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  left: widget.value ? 50 : 0,
                  right: widget.value ? 0 : 50,
                  top: 5,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(child: child, scale: animation);
                    },
                    child: widget.value
                        ? Neumorphic(
                            style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle(),
                              lightSource: LightSource.topLeft,
                              depth: 0,
                              // color: Colors.white,
                            ),
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.nights_stay,
                              color: NeumorphicTheme.accentColor(context),
                              size: 20,
                            ),
                          )
                        : Neumorphic(
                            style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.circle(),
                              lightSource: LightSource.topLeft,
                              depth: 0,
                              color: NeumorphicTheme.accentColor(context),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.wb_sunny,
                              color: NeumorphicTheme.baseColor(context),
                              size: 20,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
