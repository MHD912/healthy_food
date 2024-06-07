import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';
import 'package:healthy_food/core/widget/custom_text_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Scaffold _buildPage(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackgroundEclipseGradient(
              radius: 0.9,
              colors: [
                AppTheme.celadonGreenColor.withAlpha(255),
                AppTheme.whiteColor.withAlpha(200),
              ],
            ),
            Container(
              height: deviceHeight,
              width: deviceWidth,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _selectProfilePicture(),
                  const SizedBox(height: 45),
                  const CustomTextField(
                    text: "Username",
                  ),
                  CustomTextField(
                    text: "Email",
                    iconPath: "assets/icons/edit_icon.svg",
                    onIconPressed: () {},
                  ),
                  const CustomTextField(
                    text: "Mobile Number",
                  ),
                  CustomTextField(
                    text: "Password",
                    iconPath: "assets/icons/visibility_off.svg",
                    onIconPressed: () {},
                  ),
                  CustomTextField(
                    text: "Confirm Password",
                    iconPath: "assets/icons/visibility_off.svg",
                    onIconPressed: () {},
                  ),
                  _selectCertificateButton(),
                  const SizedBox(height: 45),
                  _signupButton(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: 13,
                          color: AppTheme.camaroneColor,
                        ),
                      ),
                      _loginButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectCertificateButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: MaterialButton(
        onPressed: () {},
        color: AppTheme.textFieldFillColor,
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: AppTheme.textFieldBorderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Certificate PDF file",
              style: TextStyle(
                fontFamily: "Cabin",
                fontSize: 13,
                color: AppTheme.springRainColor,
              ),
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              "assets/icons/cloud_upload.svg",
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _selectProfilePicture() {
    return MaterialButton(
      onPressed: () {},
      shape: const CircleBorder(),
      child: SvgPicture.asset(
        "assets/icons/camera_in_circle.svg",
        height: 100,
      ),
    );
  }

  Widget _signupButton() {
    return MaterialButton(
      onPressed: () {
        Get.toNamed('/authentication');
      },
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
        "Sign up",
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

  Widget _loginButton() {
    return TextButton(
      onPressed: () {
        Get.toNamed('/login');
      },
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        padding: const WidgetStatePropertyAll(
          EdgeInsets.zero,
        ),
        overlayColor: WidgetStatePropertyAll(
          AppTheme.pepperMintColor,
        ),
      ),
      child: Text(
        "Login",
        style: TextStyle(
          fontFamily: "Cabin",
          fontSize: 13,
          color: AppTheme.forestGreenColor,
        ),
      ),
    );
  }
}
