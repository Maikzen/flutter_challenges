import 'package:flutter/material.dart';
import 'package:flutter_challenges/animation_beers/models/beer.dart';
import 'package:flutter_challenges/animation_beers/widgets/beer_image_widget.dart';

class BeerContainer extends StatelessWidget {
  final Beer beer;

  const BeerContainer({Key? key, required this.beer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _padding = 8;
    double widthContainerBeerCollapsed =
        (MediaQuery.of(context).size.width - _padding * 2) / 3;
    double widthBeer = widthContainerBeerCollapsed * 0.7;
    double widthContainerBeer =
        MediaQuery.of(context).size.width - _padding * 2 + widthBeer / 2;
    return Stack(
      children: [
        Positioned(
          left: 0,
          width: widthContainerBeer - widthBeer / 2,
          top: 10,
          bottom: 10,
          child: Container(
            color: beer.color,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: widthBeer, left: 10),
                child: Text(
                  beer.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: BeerImage(beer: beer),
        ),
      ],
    );
  }
}
