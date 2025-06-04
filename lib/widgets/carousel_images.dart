import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImages extends StatefulWidget {
  const CarouselImages({super.key});

  @override
  State<StatefulWidget> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  List<String> images = [
    'assets/images/slider_image3.png',
    'assets/images/slider_image1.png',
    'assets/images/slider_image2.png',
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          CarouselSlider(
            items:
                images.map((image) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
            options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              //current page should be larger than other page
              enlargeCenterPage: true,
              aspectRatio: 2.5,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),

          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                images.asMap().entries.map((entry) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _currentIndex == entry.key
                              ? Colors.brown
                              : Colors.grey.shade400,
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
