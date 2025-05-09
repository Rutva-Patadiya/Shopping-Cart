import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  static const route = '/product_upload';

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  File? svgFile;
  String? svgUrl;

  Future<void> pickSvgFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['svg'],
    );
    if (result != null) {
      setState(() {
        svgFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadSvgToStorage() async {
    if (svgFile == null) return;
    final ref = FirebaseStorage.instance.ref(
      'product_images/${DateTime.now().millisecondsSinceEpoch}.svg',
    );
    await ref.putFile(svgFile!);
    svgUrl = await ref.getDownloadURL();
  }

  Future<void> addProduct() async {
    await uploadSvgToStorage();

    await FirebaseFirestore.instance.collection('products').add({
      'name': nameController.text,
      'price': double.parse(priceController.text),
      'category': categoryController.text,
      'imageUrl': svgUrl ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Product added!')));

    nameController.clear();
    priceController.clear();
    categoryController.clear();
    setState(() {
      svgFile = null;
      svgUrl = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Product Name'),
        ),
        TextField(
          controller: priceController,
          decoration: InputDecoration(labelText: 'Price'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: categoryController,
          decoration: InputDecoration(labelText: 'Category'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: pickSvgFile,
          child: Text(svgFile == null ? 'Pick SVG Image' : 'SVG Selected'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: addProduct, child: Text('Add Product')),
      ],
    );
    // }Widget build(BuildContext context) {
    //   return Scaffold(
    //     appBar: AppBar(title: Text('Add Product')),
    //     body: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Column(
    //         children: [
    //           TextField(
    //             controller: nameController,
    //             decoration: InputDecoration(labelText: 'Product Name'),
    //           ),
    //           TextField(
    //             controller: priceController,
    //             decoration: InputDecoration(labelText: 'Price'),
    //             keyboardType: TextInputType.number,
    //           ),
    //           TextField(
    //             controller: categoryController,
    //             decoration: InputDecoration(labelText: 'Category'),
    //           ),
    //           const SizedBox(height: 10),
    //           ElevatedButton(
    //             onPressed: pickSvgFile,
    //             child: Text(svgFile == null ? 'Pick SVG Image' : 'SVG Selected'),
    //           ),
    //           const SizedBox(height: 20),
    //           ElevatedButton(onPressed: addProduct, child: Text('Add Product')),
    //         ],
    //       ),
    //     ),
    //   );
    // }
  }
}
