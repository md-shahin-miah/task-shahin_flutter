import 'package:flutter/material.dart';

import 'app_colors.dart';

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular((12)),
    borderSide: const BorderSide(color: AppColors.primaryColor),
  );
}

OutlineInputBorder outlineInputBorderForSearch() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular((12)),
    borderSide: const BorderSide(color: AppColors.primaryColor),
  );
}