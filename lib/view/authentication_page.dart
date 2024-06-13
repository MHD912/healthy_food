import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:healthy_food/controller/authentication_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/widget/success_bottom_sheet.dart';
import 'package:healthy_food/core/utility/uppercase_text_formatter.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';

class AuthenticationPage extends StatelessWidget {
  final double _deviceHeight, _deviceWidth;
  AuthenticationPage({super.key})
      : _deviceHeight = Get.height,
        _deviceWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Scaffold _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackgroundEclipseGradient(
              colors: [
                AppTheme.celadonGreenColor.withAlpha(150),
                AppTheme.whiteColor.withAlpha(5),
              ],
            ),
            Container(
              height: _deviceHeight,
              width: _deviceWidth,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.06,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _appLogoWidget(),
                  const SizedBox(height: 35),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Verification Code",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        color: AppTheme.camaroneColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "We have sent the verification code to your email address",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.blackColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _deviceHeight * 0.095,
                  ),
                  _pinCodeTextField(context),
                  const SizedBox(height: 5),
                  _timeCounter(),
                  _sendAgainButton(),
                  SizedBox(
                    height: _deviceHeight * 0.15,
                  ),
                  _submitButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset(
            "assets/icons/back_button.svg",
          ),
        ),
      ),
      leadingWidth: 50,
    );
  }

  Widget _appLogoWidget() {
    return Container(
      height: _deviceHeight * 0.095,
      margin: const EdgeInsets.only(top: 65),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/healthy_food_logo_with_shadow.png",
          ),
        ),
      ),
    );
  }

  Widget _pinCodeTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: PinCodeTextField(
        // controller: ,
        appContext: context,
        length: 6,
        obscureText: false,
        animationType: AnimationType.scale,
        textStyle: TextStyle(
          color: AppTheme.darkGreyColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin',
          fontSize: 15,
        ),
        errorTextSpace: 25,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.circle,
          borderRadius: BorderRadius.circular(48),
          borderWidth: 0.5,
          fieldHeight: 48,
          fieldWidth: 48,
          activeColor: AppTheme.celadonGreenColor,
          activeFillColor: Colors.white,
          inactiveColor: AppTheme.lightGreyColor,
          inactiveFillColor: Colors.white,
          selectedColor: AppTheme.celadonGreenColor,
          selectedFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        inputFormatters: [
          UpperCaseTextFormatter(),
        ],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the code';
          }
          return null;
        },
        onCompleted: (value) {
          // Handle pin code completion
        },
        onChanged: (value) {
          // Handle pin code change
        },
      ),
    );
  }

  Widget _timeCounter() {
    return GetX<AuthenticationController>(
      builder: (controller) => Text(
        controller.timerString.value,
        style: TextStyle(
          color: AppTheme.camaroneColor,
          fontFamily: 'Mohamedamer_EBN',
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _sendAgainButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: GetX<AuthenticationController>(
        builder: (controller) => TextButton(
          onPressed: () {
            if (controller.timerDone.value) {
              controller.startTimer();
            } else {
              Get.showSnackbar(
                GetSnackBar(
                  titleText: Text(
                    "We can't send another code before the timer is up.",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  messageText: const SizedBox.shrink(),
                  backgroundColor: AppTheme.blackColor,
                  duration: const Duration(seconds: 4),
                  snackStyle: SnackStyle.FLOATING,
                  margin: const EdgeInsets.all(50),
                  borderRadius: 10,
                ),
              );
            }
          },
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(
              (controller.timerDone.value)
                  ? AppTheme.pepperMintColor
                  : Colors.transparent,
            ),
          ),
          child: Text(
            "Send again",
            style: TextStyle(
              fontSize: 16,
              color: (controller.timerDone.value)
                  ? AppTheme.camaroneColor
                  : AppTheme.darkGreyColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: MaterialButton(
        onPressed: () {
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) {
          //     return const SuccessBottomSheet();
          //   },
          // );
          Get.bottomSheet(
            const SuccessBottomSheet(),
            isDismissible: false,
          );
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
          "Submit",
          style: AppTheme.buttonTextStyle,
        ),
      ),
    );
  }
}
