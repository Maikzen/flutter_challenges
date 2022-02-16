import 'package:flutter/material.dart';
import 'package:flutter_challenges/daily_ui/widgets/light_switch.dart';
import 'package:flutter_challenges/daily_ui/widgets/main_text.dart';

const Color lightColorBackground = Colors.yellow;
const Color darkColorBackground = Colors.black87;
const Color lightColorText = darkColorBackground;
const Color darkColorText = Colors.white;
enum LightState { light, dark }

class DailyUIScreen extends StatefulWidget {
  const DailyUIScreen({Key? key}) : super(key: key);

  @override
  State<DailyUIScreen> createState() => _DailyUIScreenState();
}

class _DailyUIScreenState extends State<DailyUIScreen>
    with TickerProviderStateMixin {
  LightState _lightState = LightState.dark;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
        animationController.addListener(_listener);
    super.initState();
  }

  _listener(){
    if(animationController.isCompleted){
      setState(() {
        _lightState = LightState.light;
      });
    }
    if(animationController.isDismissed){
      setState(() {
        _lightState = LightState.dark;
      });
    }
  }

  @override
  void dispose() {
    animationController.removeListener(_listener);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _lightState == LightState.light
            ? lightColorBackground
            : darkColorBackground,
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: MainText(lightState: _lightState),
                ),
                Expanded(
                  flex: 1,
                  child: LightSwitch(
                    lightState: _lightState,
                    animationController: animationController,
                  ),
                )
              ],
            ),
            Positioned(top: 0.0, left: 0.0, right: 0.0, child: _appBar(context))
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color:
              _lightState == LightState.light ? lightColorText : darkColorText,
        ),
      ),
    );
  }
}
