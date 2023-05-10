import 'package:cwnumeal/widget/jua_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuSwitch extends StatefulWidget {
  final List<String> elements;
  final Function(int) onChanged;
  final int selectedIndex;

  const NeuSwitch(
      {Key? key,
      required this.elements,
      required this.onChanged,
      required this.selectedIndex})
      : super(key: key);

  @override
  State<NeuSwitch> createState() => _NeuSwitchState();
}

class _NeuSwitchState extends State<NeuSwitch> {
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
          width: 60 * widget.elements.length.toDouble(),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: NeumorphicTheme.accentColor(context),
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < widget.elements.length; i++)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          widget.onChanged(i);
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          height: 42,
                          child: Center(
                            child: JuaText(
                              text: widget.elements[i],
                              fontSize: 15,
                              bold: true,
                              color: NeumorphicTheme.baseColor(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut, // 63 = 3, 67 = 2
                left: (widget.selectedIndex) *
                    (70 - ((widget.elements[0].length - 1) * 3)),
                right: (widget.elements.length - widget.selectedIndex - 1) *
                    (70 - ((widget.elements[0].length - 1) * 3)),
                top: 4,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(child: child, scale: animation);
                  },
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.stadium(),
                      lightSource: LightSource.topLeft,
                      depth: 0,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    child: Container(
                      height: 32,
                      child: Center(
                        child: JuaText(
                          text: widget.elements[widget.selectedIndex],
                          fontSize: 15,
                          bold: true,
                          color: NeumorphicTheme.accentColor(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
