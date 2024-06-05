import 'package:flutter/material.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: Stack(
        children: [
          BackgroundEclipseGradient(
            colors: [
              AppTheme.celadonGreenColor.withAlpha(150),
              AppTheme.whiteColor.withAlpha(5),
            ],
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 140,
                        // width: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/healthy_food_logo.png",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 45),
                      customTextField(
                        text: "Email",
                        iconPath: "assets/icons/edit_icon.svg",
                      ),
                      customTextField(
                        text: "Mobile Number",
                      ),
                      customTextField(
                        text: "Password",
                        iconPath: "assets/icons/visibility_off.svg",
                      ),
                      loginButton(),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          rememberMeButton(),
                          forgotPasswordButton(),
                        ],
                      ),
                    ],
                  ),
                ),
                createAccountButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customTextField({
    required String text,
    String? iconPath,
    Size? iconSize,
  }) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        decoration: AppTheme.textFieldDecoration(
          labelText: text,
          iconPath: iconPath,
          iconSize: iconSize,
        ),
      ),
    );
  }

  Widget loginButton() {
    return MaterialButton(
      onPressed: () {},
      height: 35,
      minWidth: double.infinity,
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      color: AppTheme.celadonGreenColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: AppTheme.summerGreenColor,
          width: 1,
        ),
      ),
      child: Text(
        "Log in",
        style: AppTheme.buttonTextStyle,
      ),
    );
  }

  Widget rememberMeButton() {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 5),
        ),
        overlayColor: WidgetStatePropertyAll(
          AppTheme.pepperMintColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            // isChecked
            //     ? Icons.check_circle_outline
            //     : Icons.circle_outlined,
            Icons.check_circle_outline,
            size: 13,
            color: AppTheme.camaroneColor,
          ),
          const SizedBox(width: 5),
          Text(
            "Remember Me",
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.camaroneColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget forgotPasswordButton() {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 8),
        ),
        overlayColor: WidgetStatePropertyAll(
          AppTheme.pepperMintColor,
        ),
      ),
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          fontFamily: "Cabin",
          fontSize: 13,
          color: AppTheme.camaroneColor,
        ),
      ),
    );
  }

  Widget createAccountButton() {
    return MaterialButton(
      onPressed: () {},
      height: 35,
      minWidth: double.infinity,
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      color: AppTheme.pepperMintColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: AppTheme.springRainColor,
          width: 1,
        ),
      ),
      child: Text(
        "Create new account",
        style: AppTheme.buttonTextStyle,
      ),
    );
  }
}
