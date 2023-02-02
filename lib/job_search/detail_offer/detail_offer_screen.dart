// ignore_for_file: must_be_immutable

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_challenges/job_search/models/offer.dart';

class DetailOfferScreen extends StatefulWidget {
  Offer offer;

  DetailOfferScreen({Key? key, required this.offer}) : super(key: key);

  static Color backgroundColor = Colors.white;

  @override
  State<DetailOfferScreen> createState() => _DetailOfferScreenState();
}

class _DetailOfferScreenState extends State<DetailOfferScreen>
    with TickerProviderStateMixin {
  late double widthCardOffer;

  final TextStyle textStyle = const TextStyle(color: Colors.white);

  final TextStyle textStyleMap = const TextStyle(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);

  final TextStyle textStyleBold = const TextStyle(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

  final TextStyle textStyleBoldTitle = const TextStyle(
      color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    widthCardOffer = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      body: Hero(
        tag: "offer${widget.offer.id}",
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
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Stack(
              children: [
                _content(context),
                Positioned(
                  top: 0,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/curve.png"),
                            alignment: Alignment.topCenter,
                            opacity: 0.12),
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.arrow_downward,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _content(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainInfo(context),
            const SizedBox(
              height: 30,
            ),
            _buildRequeriments(),
            const SizedBox(
              height: 30,
            ),
            _buildRecruiterInfo(),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Qualifications",
                  style: textStyleBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  style: textStyle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox _buildMainInfo(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(child: _buildInfo()),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/map_full.JPG"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "New York",
                        style: textStyleMap,
                      ),
                      Expanded(
                          child: Center(
                        child: Image.asset(
                          "assets/img/marker.png",
                          height: 35,
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                _buildCardInfo(
                    context,
                    const Icon(
                      Icons.time_to_leave,
                      color: Colors.white,
                    ),
                    "Full-time"),
                const SizedBox(
                  width: 30,
                ),
                _buildCardInfo(
                    context,
                    Text(
                      "620",
                      style: textStyleBold,
                    ),
                    "Submitted"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _buildRequeriments() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "5+ years",
                style: textStyleBold,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Experience of Design",
                style: textStyle,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bachelor's",
                style: textStyleBold,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Degree",
                style: textStyle,
              ),
            ],
          ),
        )
      ],
    );
  }

  Row _buildRecruiterInfo() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/recruiter.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Emily Hughes",
                  style: textStyleBold,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Recruiter",
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(15)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    )),
                child: const Icon(
                  Icons.message_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCardInfo(BuildContext context, Widget title, String subtitle) {
    return ClipRRect(
      child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10.0,
            sigmaY: 10.0,
          ),
          child: Container(
            height: 80,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    subtitle,
                    style: textStyle,
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        _buildImageOffer(widget.offer),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.offer.company,
          style: textStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: widthCardOffer / 2,
          child: Text(
            widget.offer.title,
            style: textStyleBoldTitle,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        RichText(
          text: TextSpan(
            text: "\$ ${widget.offer.salary}",
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
            children: const <TextSpan>[
              TextSpan(
                text: " / year",
                style: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
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
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Image.asset(
                offer.image,
              ),
            ),
          )),
    );
  }
}
