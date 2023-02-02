import 'package:flutter/material.dart';
import 'package:flutter_challenges/appliances/models/item.dart';

const TextStyle textStyleCard =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);

List<Item> listItems = [
  Item(
      id: 1,
      name: "Power bank",
      image: "assets/img/earphone_example.JPG",
      subtitle: "\$ 175",
      color: Colors.amberAccent),
  Item(
      id: 2,
      name: "Headset",
      image: "assets/img/earphone_example.JPG",
      subtitle: "\$ 175",
      color: Colors.orange),
  Item(
      id: 3,
      name: "Earphone",
      image: "assets/img/earphone_example.JPG",
      subtitle: "\$ 175",
      color: Colors.redAccent),
  Item(
      id: 4,
      name: "Earphone",
      image: "assets/img/earphone_example.JPG",
      subtitle: "\$ 175",
      color: Colors.redAccent),
  Item(
      id: 5,
      name: "Earphone",
      image: "assets/img/earphone_example.JPG",
      subtitle: "\$ 175",
      color: Colors.redAccent),
  Item(
      id: 6,
      name: "Earphone",
      image: "assets/img/earphone_example.JPG",
      subtitle: "\$ 175",
      color: Colors.redAccent),
];

class DetailScreen extends StatelessWidget {
  final Item item;
  const DetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            titleSpacing: 0,
            floating: false,
            flexibleSpace: Stack(
              children: [
                Hero(
                  tag: "image${item.id}",
                  child: Container(
                    decoration: BoxDecoration(
                      image: item.image != ""
                          ? DecorationImage(
                              image: AssetImage(item.image),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: item.color.withOpacity(0.9),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Hero(
                      tag: "text${item.id}",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          item.name,
                          style: textStyleCard,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ),
          SliverList(
            delegate: SliverChildListDelegate(_getListItems(context)),
          ),
        ],
      ),
    );
  }

  Widget _cardDetail(Item item, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.4,
                width: MediaQuery.of(context).size.width * 0.4,
                child: item.image != ""
                    ? Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image),
              ),
              Text(
                item.name,
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
              Text(
                item.subtitle!,
                style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getListItems(BuildContext context) {
    List<Widget> rows = [];
    List<Widget> itemsRow = [];
    for (int i = 0; i < listItems.length; i++) {
      itemsRow.add(_cardDetail(listItems[i], context));
      if ((i + 1) % 2 == 0) {
        rows.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: itemsRow.toList(),
            ),
          ),
        );
        itemsRow.clear();
      } else if (i == listItems.length - 1) {
        itemsRow.add(Expanded(
          child: Container(),
        ));
        rows.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: itemsRow.toList(),
            ),
          ),
        );
        itemsRow.clear();
      }
    }

    return rows;
  }
}
