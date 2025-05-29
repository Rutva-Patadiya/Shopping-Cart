// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
//
// class CarouselImages extends StatefulWidget {
//   const CarouselImages({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _CarouselImagesState();
// }
//
// class _CarouselImagesState extends State<CarouselImages> {
//   List<String> images = [
//     'assets/images/profile.jpg',
//     'assets/images/slider_image1.jpg',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         SizedBox(
//           height: 200,
//           child: CarouselSlider(
//             options: CarouselOptions(height: 400.0),
//             items:
//                 [images].map((i) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return Container(
//                         width: MediaQuery.of(context).size.width,
//                         margin: EdgeInsets.symmetric(horizontal: 5.0),
//                         decoration: BoxDecoration(color: Colors.amber),
//                         child: Text(
//                           'text $i',
//                           style: TextStyle(fontSize: 16.0),
//                         ),
//                       );
//                     },
//                   );
//                 }).toList(),
//           ),
//           // child: CarouselSlider(
//           //   items:
//           //       images.map((imagePath) {
//           //         return Container(
//           //           margin: EdgeInsets.all(8),
//           //           decoration: BoxDecoration(
//           //             borderRadius: BorderRadius.circular(10),
//           //             image: DecorationImage(
//           //               image: AssetImage(imagePath),
//           //               fit: BoxFit.cover,
//           //             ),
//           //           ),
//           //         );
//           //       }).toList(),
//           //   options: CarouselOptions(
//           //     initialPage: 0,
//           //     enableInfiniteScroll: true,
//           //     autoPlay: true,
//           //     enlargeCenterPage: true,
//           //   ),
//           // ),
//         ),
//       ],
//     );
//   }
// }
