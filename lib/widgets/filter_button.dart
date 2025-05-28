import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/theme/theme.dart';
import '../product/bloc/filter_product_bloc.dart';
import '../product/bloc/filter_product_event.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.brown,
      ),

      margin: const EdgeInsets.only(left: 8),
      child: IconButton(
        icon: const Icon(Icons.tune_outlined, color: Colors.white),
        onPressed: () {
          context.read<ProductBloc>().add(InitialProductLoaded());
        },
      ),
    );
  }
}
