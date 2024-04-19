import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CursorWidget extends StatelessWidget {
  const CursorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: CarouselSlider.builder(
        itemCount: 4,
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          final images = [
            'https://media.assettype.com/freepressjournal/2020-11/c0b43bab-e78a-4229-9808-183e4e4e49ea/Representative.jpg',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUa-zgIRdK5Y6IootwePOrrL4mv5BtCv36dg&usqp=CAU',
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8XZsPRVGQjDAr0cg9QTMhGuo3WYLnHJB_Lg&usqp=CAU',
            'https://protectorfiresafety.com/15586-large_default/emergency-phone-number.jpg'
          ];
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 3.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(images[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
