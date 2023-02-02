import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_challenges/appliances/detail/detail_screen.dart';
import 'package:flutter_challenges/appliances/models/item.dart';

List<Item> listItems = [
  Item(
      id: 1,
      name: "Power bank",
      image: "assets/img/powerbank.JPG",
      color: Colors.amberAccent),
  Item(
      id: 2,
      name: "Headset",
      image: "assets/img/headset.JPG",
      color: Colors.orange),
  Item(
      id: 3,
      name: "Earphone",
      image: "assets/img/earphone.jpg",
      color: Colors.redAccent),
  Item(id: 4, name: "Light", image: "", color: Colors.red),
  Item(id: 5, name: "Filter", image: "", color: Colors.purple),
];

List<Item> listItemsHome = [
  Item(
      id: 1,
      name: "Speakers",
      subtitle: "Starting at \$ 290",
      image: "assets/img/headset.JPG",
      color: Colors.orange),
  Item(
      id: 2,
      name: "Speakers",
      subtitle: "Starting at \$ 290",
      image: "assets/img/earphone.jpg",
      color: Colors.redAccent),
];

List<AnimationController> listAnimations = [];

int indexActive = 0;
double factorWidthExpanded = 0.4;
const TextStyle textStyleCard =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
const TextStyle textStyleCardTitle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
const TextStyle textStyleCardSubtitle = TextStyle(
  color: Colors.white,
);

class AppliancesScreen extends StatefulWidget {
  const AppliancesScreen({Key? key}) : super(key: key);

  @override
  State<AppliancesScreen> createState() => _AppliancesScreenState();
}

class _AppliancesScreenState extends State<AppliancesScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    listAnimations = List.generate(
        listItems.length,
        (index) => AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 300),
            value: indexActive == index ? 1 : 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Appliances",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.purple),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Popular",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    TextButton(child: const Text("see all"), onPressed: () {})
                  ],
                ),
              ),
              subtitle: Row(
                children: listItems.mapIndexed(
                  (index, e) {
                    return _cardItem(index, e);
                  },
                ).toList(),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "For your own home studio",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    TextButton(child: const Text("see all"), onPressed: () {})
                  ],
                ),
              ),
              subtitle: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: listItemsHome.map((e) => _getCardList(e)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardItem(int indexSelected, Item e) {
    double widthExpanded =
        MediaQuery.of(context).size.width * factorWidthExpanded;
    double widthCollapsed = MediaQuery.of(context).size.width *
        ((1 - factorWidthExpanded) / (listItems.length - 1));
    AnimationController animationController = listAnimations[indexSelected];
    return GestureDetector(
      onTap: () {
        _onTapCard(indexSelected, e);
      },
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return SizedBox(
              width: widthCollapsed +
                  (listAnimations[indexSelected].value *
                      (widthExpanded - widthCollapsed)),
              height: MediaQuery.of(context).size.height * 0.25,
              child: Padding(
                padding: EdgeInsets.only(left: indexSelected == 0 ? 0 : 3.0),
                child: Stack(
                  children: [
                    Hero(
                      tag: "image${e.id}",
                      child: Container(
                        decoration: BoxDecoration(
                          image: e.image != ""
                              ? DecorationImage(
                                  image: AssetImage(e.image),
                                  fit: BoxFit.cover,
                                  opacity: listAnimations[indexSelected].value,
                                )
                              : null,
                          color: e.color.withOpacity(0.9),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                    Center(
                      child: Transform.rotate(
                        angle:
                            (-pi * 0.5) * listAnimations[indexSelected].value,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Hero(
                            tag: "text${e.id}",
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                e.name,
                                style: textStyleCard,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void _onTapCard(int indexSelected, Item e) async {
    if (indexSelected == indexActive) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailScreen(
          item: e,
        ),
      ));
    } else {
      listAnimations[indexSelected].forward();
      listAnimations[indexActive].reverse();

      indexActive = indexSelected;
    }
  }

  Widget _getCardList(Item e) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(e.image),
            fit: BoxFit.cover,
          ),
          color: e.color.withOpacity(0.9),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                e.name,
                style: textStyleCardTitle,
              ),
              Text(
                e.subtitle!,
                style: textStyleCardSubtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var animation in listAnimations) {
      animation.dispose();
    }
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
