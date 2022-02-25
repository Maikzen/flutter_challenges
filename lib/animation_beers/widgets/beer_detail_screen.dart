import 'package:flutter/material.dart';
import 'package:flutter_challenges/animation_beers/models/beer.dart';
import 'package:flutter_challenges/animation_beers/widgets/beer_container_widget.dart';

class BeerDetailScreen extends StatelessWidget {
  final Beer beer;
  const BeerDetailScreen({Key? key, required this.beer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _header(context),
            Expanded(
              child: _content(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descripción',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: beer.color),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fringilla leo nec ante consectetur tristique. Nunc eleifend at sem viverra hendrerit. Donec metus tortor, iaculis at odio a, ultricies euismod felis. Vestibulum congue arcu posuere odio faucibus, ac auctor orci rutrum. Nulla ac venenatis elit. Nam sit amet sodales eros. Suspendisse ut nisi tempus, imperdiet tortor vel, imperdiet purus.'),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    beer.desc,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    'From \$' + beer.price.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Order',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black12),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
  }

  Widget _header(BuildContext context) {
    double _padding = 8;
    double widthContainerBeerCollapsed =
        (MediaQuery.of(context).size.width - _padding * 2) / 3;
    double widthBeer = widthContainerBeerCollapsed * 0.7;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: -widthBeer / 2,
              child: Hero(
                tag: beer.id,
                child: BeerContainer(beer: beer),
              ),
            ),
            Positioned(
              left: 20,
              top: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
