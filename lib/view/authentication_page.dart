import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:healthy_food/core/theme/app_theme.dart';
import 'package:healthy_food/core/utility/uppercase_text_formatter.dart';
import 'package:healthy_food/core/widget/background_eclipse_gradient.dart';
import 'package:healthy_food/core/widget/warning_dialog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Scaffold _buildPage(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
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
              height: deviceHeight,
              width: deviceWidth,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
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
                      const SizedBox(height: 80),
                      _pinCodeTextField(context),
                      const SizedBox(height: 5),
                      _timeCounter(),
                      _sendAgainButton()
                    ],
                  ),
                  Flexible(
                    child: _submitButton(context),
                  ),
                  // const SizedBox(height: 5),
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
      height: 80,
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
    return Text(
      "03:00",
      style: TextStyle(
        color: AppTheme.camaroneColor,
        fontFamily: 'Mohamedamer_EBN',
        fontSize: 17,
      ),
    );
  }

  Widget _sendAgainButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          overlayColor: WidgetStatePropertyAll(
            AppTheme.pepperMintColor,
          ),
        ),
        child: Text(
          "Send again",
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.camaroneColor,
          ),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 140),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: MaterialButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierColor: AppTheme.whiteColor.withOpacity(0.6),
            builder: (context) {
              return const WarningDialog();
            },
          );
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
          "Send",
          style: AppTheme.buttonTextStyle,
        ),
      ),
    );
  }
}
