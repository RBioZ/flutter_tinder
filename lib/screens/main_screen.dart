// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tinder/components/tinder_card.dart';
import 'package:flutter_tinder/providers/card_provider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: buildCards(),
          ),
        ),
      );

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.urlImages;

    return urlImages.isEmpty
        ? Center(
            child: ElevatedButton(
              child: Text("Restart"),
              onPressed: () {
                final provider =
                    Provider.of<CardProvider>(context, listen: false);
                provider.resetUsers();
              },
            ),
          )
        : Stack(
            children: urlImages
                .map(
                  (urlImage) => TinderCard(
                    urlImage: urlImage,
                    isFront: urlImages.last == urlImage,
                  ),
                )
                .toList());
  }
}
