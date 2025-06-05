import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/theme/theme.dart';
import '../product/bloc/product_bloc.dart';
import '../product/bloc/product_event.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.brown,
      ),

      margin: const EdgeInsets.only(left: 8, bottom: 12),
      child: IconButton(
        icon: const Icon(Icons.tune_outlined, color: Colors.white),
        onPressed: () {
          //It will filter the products by all categories
          context.read<ProductBloc>().add(ProductFilteredEvent('All', null));
        },
      ),
    );
  }
}
