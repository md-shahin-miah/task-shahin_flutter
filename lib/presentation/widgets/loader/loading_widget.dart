import 'package:flutter/material.dart';
import '../../../common/themes/styles/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(strokeWidth: 1.5, color: AppColors.secondaryColors,),
      ),
    );
  }
}
