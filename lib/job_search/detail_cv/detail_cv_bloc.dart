import 'package:flutter/material.dart';
import 'package:flutter_challenges/job_search/models/offer.dart';

class DetailCVBloc extends ChangeNotifier {
  PageController pageController = PageController();
  List<Offer> listOffers = [
    Offer(
        id: 1,
        company: "Apple",
        image: "assets/img/apple.png",
        title: "Product Designer",
        salary: "120k"),
    Offer(
        id: 2,
        company: "Google",
        image: "assets/img/google.png",
        title: "Product Designer",
        salary: "100k"),
    Offer(
        id: 3,
        company: "Microsoft",
        image: "assets/img/microsoft.png",
        title: "Product Designer",
        salary: "110k"),
    Offer(
        id: 4,
        company: "Apple",
        image: "assets/img/apple.png",
        title: "Product Designer",
        salary: "120k"),
    Offer(
        id: 5,
        company: "Google",
        image: "assets/img/google.png",
        title: "Product Designer",
        salary: "100k"),
    Offer(
        id: 6,
        company: "Microsoft",
        image: "assets/img/microsoft.png",
        title: "Product Designer",
        salary: "110k"),
  ];
}