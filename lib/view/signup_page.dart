import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy_food/controller/signup_controller.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';
import 'package:healthy_food/core/widget/custom_text_field.dart';

class SignupPage extends StatelessWidget {
  final double _deviceHeight, _deviceWidth;
  SignupPage({super.key})
      : _deviceHeight = Get.height,
        _deviceWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Scaffold _buildPage(BuildContext context) {
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
              height: _deviceHeight,
              width: _deviceWidth,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.1,
              ),
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
                  GetX<SignupController>(
                    builder: (controller) => CustomTextField(
                      text: "Password",
                      iconPath: (controller.showPassword.value)
                          ? "assets/icons/visibility_on.svg"
                          : "assets/icons/visibility_off.svg",
                      onIconPressed: () {
                        controller.toggleShowPassword();
                      },
                    ),
                  ),
                  GetX<SignupController>(
                    builder: (controller) => CustomTextField(
                      text: "Confirm Password",
                      iconPath: (controller.showConfirmPassword.value)
                          ? "assets/icons/visibility_on.svg"
                          : "assets/icons/visibility_off.svg",
                      onIconPressed: () {
                        controller.toggleShowConfirmPassword();
                      },
                    ),
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
        height: _deviceHeight * 0.12,
      ),
    );
  }

  Widget _signupButton() {
    return MaterialButton(
      onPressed: () {
        Get.toNamed('/authentication');
      },
      height: 35,
      minWidth: _deviceWidth,
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

  Widget _loginButton() {
    return TextButton(
      onPressed: () {
        Get.offAllNamed('/login');
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
