

import 'package:flutter/material.dart';
import 'package:flutter_challenges/daily_ui/daily_ui_screen.dart';

class MainText extends StatelessWidget {
  const MainText({
    Key? key,
    required LightState lightState,
  }) : _lightState = lightState, super(key: key);

  final LightState _lightState;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bedroom',
            style: TextStyle(
                color: _lightState == LightState.light
                    ? lightColorText
                    : darkColorText,
                fontSize: 50,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '74°',
            style: TextStyle(
                color: _lightState == LightState.light
                    ? lightColorText
                    : darkColorText,
                fontSize: 30),
          ),
        ],
      ),
    );
  }
}
