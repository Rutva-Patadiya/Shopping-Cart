import 'package:flutter/material.dart';
import 'package:shopping_cart/core/utils/theme/text_theme.dart';
import 'package:shopping_cart/core/utils/theme/theme.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.brown,
        title: Text(
          'Favorite Page',
          style: TTextTheme.lightTextTheme.headlineLarge?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
