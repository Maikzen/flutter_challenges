import 'package:flutter/material.dart';
import 'package:flutter_challenges/animation_beers/data/beers.dart';
import 'package:flutter_challenges/animation_beers/widgets/beer_widget.dart';

class AnimationBeersScreen extends StatefulWidget {
  const AnimationBeersScreen({Key? key}) : super(key: key);

  @override
  State<AnimationBeersScreen> createState() => _AnimationBeersScreenState();
}

class _AnimationBeersScreenState extends State<AnimationBeersScreen> {
  @override
  Widget build(BuildContext context) {
    double _padding = MediaQuery.of(context).size.height * 0.05;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            _appBar(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ListView.separated(
                  itemCount: beers.length + 1,
                  separatorBuilder: (context, index) => Container(
                    height: _padding,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const SizedBox();
                    }
                    return BeerWidget(beer: beers[index - 1]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        title: const Text(
          'Beer',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
        backgroundColor: Colors.black12,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
    );
  }
}
