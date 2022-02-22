import 'package:flutter/material.dart';

class ButtonClose extends StatelessWidget {
  const ButtonClose({
    Key? key,
    required this.function,
  }) : super(key: key);

  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextButton(
        onPressed: function,
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black12),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ))),
      ),
    );
  }
}
