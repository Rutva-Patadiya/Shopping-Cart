import 'package:flutter/material.dart';

import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Message Page',
          style: TTextTheme.lightTextTheme.headlineLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.brown,
      ),
    );
  }
}
