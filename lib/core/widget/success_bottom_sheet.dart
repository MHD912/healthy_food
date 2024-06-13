import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SuccessBottomSheet extends StatelessWidget {
  const SuccessBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.offWhiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 3,
            width: 48,
            margin: const EdgeInsets.only(top: 15),
            color: AppTheme.lightGreyColor,
          ),
          const SizedBox(height: 15),
          SvgPicture.asset(
            "assets/icons/check_with_gradient.svg",
            height: 106,
          ),
          const SizedBox(height: 15),
          GradientText(
            "Success!",
            colors: const [
              Color(0xFFB6E5B9),
              Color(0xFF657F67),
            ],
            style: const TextStyle(
              fontFamily: 'Cabin',
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 15),
          const SizedBox(
            width: 280,
            child: Text(
              "Congratulations! You have been successfully authenticated",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cabin',
                color: Color(0xFFB6B6B6),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 30),
          _continueButton(),
        ],
      ),
    );
  }

  Widget _continueButton() {
    return MaterialButton(
      onPressed: () {
        Get.offAllNamed('/login');
      },
      minWidth: 170,
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      color: AppTheme.celadonGreenColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        "Continue",
        style: TextStyle(
          fontSize: 16,
          color: AppTheme.camaroneColor,
        ),
      ),
    );
  }
}
