import 'package:flutter/material.dart';
import 'package:flutter_challenges/animation_beers/models/beer.dart';
import 'package:flutter_challenges/animation_beers/widgets/beer_container_widget.dart';
import 'package:flutter_challenges/animation_beers/widgets/beer_detail_screen.dart';

class BeerWidget extends StatefulWidget {
  final Beer beer;

  const BeerWidget({Key? key, required this.beer}) : super(key: key);

  @override
  State<BeerWidget> createState() => _BeerWidgetState();
}

class _BeerWidgetState extends State<BeerWidget> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = _animationController.drive(CurveTween(curve: Curves.ease));
    _animationController.addListener(_listener);
  }

  @override
  void dispose() {
    _animationController.removeListener(_listener);
    _animationController.dispose();
    super.dispose();
  }

  _listener() {
    if (_animationController.isCompleted) {
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (context) => BeerDetailScreen(beer: widget.beer),
      ))
          .then((value) {
        _animationController.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double _padding = 8;
    double widthContainerBeerCollapsed =
        (MediaQuery.of(context).size.width - _padding * 2) / 3;
    double widthContainerInfo = widthContainerBeerCollapsed * 2;
    double widthBeer = widthContainerBeerCollapsed * 0.7;
    double widthContainerBeer =
        MediaQuery.of(context).size.width - _padding * 2 + widthBeer / 2;
    return GestureDetector(
      onTap: () {
        if (_animationController.isDismissed) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: widthContainerInfo,
              child: _rightContent(context),
            ),
            AnimatedBuilder(
                animation: _animation,
                builder: (context, _) {
                  return Positioned(
                    left: -widthContainerInfo -
                        widthBeer / 2 +
                        (_animation.value *
                            (widthContainerInfo + widthBeer / 2)),
                    width: widthContainerBeer,
                    top: 0,
                    bottom: 0,
                    child: Hero(
                      tag: widget.beer.id,
                      child: BeerContainer(
                        beer: widget.beer,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _rightContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.beer.name,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: widget.beer.color),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.beer.desc,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'From \$' + widget.beer.price.toStringAsFixed(2),
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Order',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black12),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
}
