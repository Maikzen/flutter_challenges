import 'package:flutter/material.dart';
import 'package:flutter_challenges/side_menu_animation/models/subcategory.dart';

class SubcategoryWidget extends StatelessWidget {
  const SubcategoryWidget({Key? key, required this.subcategory})
      : super(key: key);

  final Subcategory subcategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      color: subcategory.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(subcategory.icon, color: Colors.white, size: 100,),
          const SizedBox(height: 30,),
          Text(subcategory.name, style: const TextStyle(color: Colors.white, fontSize: 40),),
        ],
      ),
    );
  }
}
