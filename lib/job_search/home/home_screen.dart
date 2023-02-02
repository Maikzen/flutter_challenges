import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_challenges/job_search/detail_cv/detail_cv_screen.dart';
import 'package:flutter_challenges/job_search/home/home_bloc.dart';

class SearchJobScreen extends StatefulWidget {
  const SearchJobScreen({Key? key}) : super(key: key);

  static Color backgroundColor = const Color.fromARGB(255, 230, 230, 230);
  static const double _space = 30;

  @override
  State<SearchJobScreen> createState() => _SearchJobScreenState();
}

class _SearchJobScreenState extends State<SearchJobScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double collapsedHeight = MediaQuery.of(context).size.height * 0.25;
    double expandedHeight = MediaQuery.of(context).size.height * 0.5;
    return Scaffold(
      backgroundColor: SearchJobScreen.backgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _homeBloc.scrollController,
            slivers: [
              SliverAppBar(
                toolbarHeight: collapsedHeight,
                titleSpacing: 0,
                floating: false,
                flexibleSpace: Container(
                  color: SearchJobScreen.backgroundColor,
                  padding: const EdgeInsets.only(right: 20, top: 20),
                  alignment: const Alignment(0.7, 1),
                  child: Image.asset("assets/img/avatar.png"),
                ),
                expandedHeight: expandedHeight,
                collapsedHeight: collapsedHeight,
                leadingWidth: 300,
                leading: _backButton(context),
              ),
              SliverList(
                delegate: SliverChildListDelegate([_buildListCV(context)]),
              ),
            ],
          ),
          AnimatedBuilder(
            animation: _homeBloc,
            builder: (context, child) => Positioned(
              left: 0,
              right: 50,
              top: MediaQuery.of(context).size.width * 0.5 -
                  _homeBloc.offset / 2 -
                  (collapsedHeight < _homeBloc.offset
                      ? ((_homeBloc.offset - collapsedHeight) / 2)
                      : 0),
              child: Image.asset("assets/img/line_chart.png"),
            ),
          ),
          AnimatedBuilder(
            animation: _homeBloc,
            builder: (context, child) => Positioned(
              left: MediaQuery.of(context).size.width * 0.5,
              top: MediaQuery.of(context).size.width * 0.5 -
                  _homeBloc.offset / 2 -
                  (collapsedHeight < _homeBloc.offset
                      ? ((_homeBloc.offset - collapsedHeight) / 2)
                      : 0),
              child: _buildCardViews(context),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  )),
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListCV(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              _buildCardCV(context, "Product Designer", "143"),
              const SizedBox(
                height: SearchJobScreen._space,
              ),
              _buildCardCV(context, "Ux Designer", "143"),
              const SizedBox(
                height: SearchJobScreen._space,
              ),
              _buildCardCV(context, "Visual Designer", "143"),
              const SizedBox(
                height: SearchJobScreen._space,
              ),
              _buildCardCV(context, "Ux Designer", "143"),
              const SizedBox(
                height: SearchJobScreen._space,
              ),
              _buildCardCV(context, "Visual Designer", "143"),
              const SizedBox(
                height: SearchJobScreen._space,
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                _buildCardCV(context, "Visual Designer", "143"),
                const SizedBox(
                  height: SearchJobScreen._space,
                ),
                _buildCardCV(context, "Product Designer", "143"),
                const SizedBox(
                  height: SearchJobScreen._space,
                ),
                _buildCardCV(context, "Ux Designer", "143"),
                const SizedBox(
                  height: SearchJobScreen._space,
                ),
                _buildCardCV(context, "Ux Designer", "143"),
                const SizedBox(
                  height: SearchJobScreen._space,
                ),
                _buildCardCV(context, "Visual Designer", "143"),
                const SizedBox(
                  height: SearchJobScreen._space,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCardCV(BuildContext context, String title, String views) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DetailCVScreen(),));
      },
      child: Column(
        children: [
          ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                  ),
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.35),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ))),
          const SizedBox(
            height: 30,
          ),
          RichText(
            text: TextSpan(
              text: '$views ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
              children: const <TextSpan>[
                TextSpan(
                  text: 'views',
                  style: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: AspectRatio(
              aspectRatio: 1,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    // fixedSize: MaterialStateProperty.all(const Size(40, 40)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
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
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 10),
            child: Text("Choose\nyour CV",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                    color: Colors.black)),
          )
        ],
      ),
    );
  }

  Widget _buildCardViews(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(
            height: 65,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Today",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: '245 ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'views',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
