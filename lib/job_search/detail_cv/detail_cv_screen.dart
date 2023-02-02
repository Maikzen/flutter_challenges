// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_challenges/job_search/detail_cv/detail_cv_bloc.dart';
import 'package:flutter_challenges/job_search/detail_offer/detail_offer_screen.dart';
import 'package:flutter_challenges/job_search/models/offer.dart';

class DetailCVScreen extends StatefulWidget {
  const DetailCVScreen({Key? key}) : super(key: key);

  static Color backgroundColor = Colors.white;

  @override
  State<DetailCVScreen> createState() => _DetailCVScreenState();
}

class _DetailCVScreenState extends State<DetailCVScreen>
    with TickerProviderStateMixin {
  late DetailCVBloc _detailCVBloc;
  late double widthCardOffer;
  late AnimationController animationController;
  List<AnimationController> listAnimations = [];

  @override
  void initState() {
    _detailCVBloc = DetailCVBloc();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    for (int i = 0; i < _detailCVBloc.listOffers.length; i++) {
      listAnimations.add(AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)));
    }
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loadAnimations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widthCardOffer = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      backgroundColor: DetailCVScreen.backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/img/map.JPG", fit: BoxFit.contain),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _backButton(context),
                        fadeInAnimationWidget(
                          controller: animationController,
                          context: context,
                          child: _buildTitle(),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            fadeInAnimationWidget(
                              controller: animationController,
                              context: context,
                              child: _buildResults(),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  fadeInUpAnimationWidget(
                                    controller: animationController,
                                    context: context,
                                    child: Image.asset(
                                      "assets/img/marker.png",
                                      height: animationController.value * 35,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  fadeInAnimationWidget(
                                    controller: animationController,
                                    context: context,
                                    child: const Text(
                                      "New York",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            child: _buildListOffers(context, _detailCVBloc.listOffers),
          )
        ],
      ),
    );
  }

  Widget _buildListOffers(BuildContext context, List<Offer> listOffers) {
    double sizeWidth = MediaQuery.of(context).size.width;
    double factorStack = sizeWidth * 0.35;
    double height = MediaQuery.of(context).size.height * 0.3;
    return SizedBox(
      height: height,
      width: sizeWidth,
      child: ListView(
        controller: _detailCVBloc.pageController,
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: (factorStack) * _detailCVBloc.listOffers.length,
            child: Stack(
              children: _detailCVBloc.listOffers.mapIndexed((index, item) {
                return AnimatedBuilder(
                  animation: listAnimations[index],
                  builder: (context, child) {
                    return Positioned(
                      top: (1 - listAnimations[index].value) * height,
                      left: 20 + (index * factorStack),
                      child: _cardOffer(context, item),
                    );
                  },
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _cardOffer(BuildContext context, Offer offer) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailOfferScreen(
            offer: offer,
          ),
        ));
      },
      child: Hero(
          tag: "offer${offer.id}",
          flightShuttleBuilder: _flightShuttleBuilder,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 22, 22, 22),
                    Color.fromARGB(255, 15, 15, 15)
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            width: widthCardOffer,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageOffer(offer),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  offer.company,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: widthCardOffer / 2,
                  child: Text(
                    offer.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "\$ ${offer.salary} / year",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildImageOffer(Offer offer) {
    return ClipRRect(
      child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(6),
            child: Center(
              child: Image.asset(
                offer.image,
              ),
            ),
          )),
    );
  }

  Widget _buildResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text(
          "We found",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        Text(
          "260",
          style: TextStyle(
              fontSize: 60, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          "Results",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }

  Padding _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 40, left: 0, bottom: 60),
      child: Text("Product\nDesigner\nVacancies",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 27, color: Colors.black)),
    );
  }

  Widget _backButton(BuildContext context) {
    return SizedBox(
      height: 50,
      child: AspectRatio(
        aspectRatio: 1,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 240, 240, 240)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              )),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget fadeInAnimationWidget(
      {required AnimationController controller,
      required Widget child,
      required BuildContext context}) {
    return Transform.translate(
        offset: Offset(
            MediaQuery.of(context).size.width * 0.2 -
                controller.value * MediaQuery.of(context).size.width * 0.2,
            0),
        child: Opacity(opacity: controller.value, child: child));
  }

  Widget fadeInUpAnimationWidget(
      {required AnimationController controller,
      required Widget child,
      required BuildContext context}) {
    return Transform.translate(
        offset: Offset(
            0,
            MediaQuery.of(context).size.width * 0.2 -
                controller.value * MediaQuery.of(context).size.width * 0.2),
        child: Opacity(opacity: controller.value, child: child));
  }

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  void _loadAnimations() async {
    animationController.forward();
    for (int i = 0; i < _detailCVBloc.listOffers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      listAnimations[i].forward();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

extension FicListExtension<T> on List<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T item) map) sync* {
    for (var index = 0; index < length; index++) {
      yield map(index, this[index]);
    }
  }
}
