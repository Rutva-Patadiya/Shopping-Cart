import 'package:cloud_firestore/cloud_firestore.dart';

class ProductColorModel {
  final String name;
  final List<ColorItem> colors;
  final String productId;

  ProductColorModel({
    required this.name,
    required this.colors,
    required this.productId,
  });

  factory ProductColorModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final List<ColorItem> colorList =
        (data['color'] as List<dynamic>).map((colorMap) {
          return ColorItem.fromMap(colorMap);
        }).toList();

    print(doc.id);
    return ProductColorModel(
      name: data['name'] ?? '',
      colors: colorList,
      productId: doc.id,
    );
  }
}

class ColorItem {
  final String name;
  final String hex;

  ColorItem({required this.name, required this.hex});

  factory ColorItem.fromMap(Map<String, dynamic> map) {
    return ColorItem(name: map['name'] ?? '', hex: map['hex'] ?? '');
  }

  @override
  String toString() => 'ColorItem(name: $name, hex: $hex)';
}
