import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTheme {
  static Color lightGreyColor = const Color(0xFFDDDDDD);
  static Color greyColor = const Color(0xFFAEB3BE);
  static Color darkGreyColor = const Color(0xFF757575);

  static Color blackColor = const Color(0xFF000000);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color offWhiteColor = const Color(0xFFFFFDFD);

  static Color christiColor = const Color(0xFF74A71A);
  static Color limeadeColor = const Color(0xFF567F05);
  static Color camaroneColor = const Color(0xFF035014);
  static Color springRainColor = const Color(0xFFA3C5B0);
  static Color pepperMintColor = const Color(0xFFE9F6E7);
  static Color forestGreenColor = const Color(0xFF25A340);
  static Color summerGreenColor = const Color(0xFF97BFA0);
  static Color celadonGreenColor = const Color(0xFFB6E5B9);

  static Color textFieldFillColor = const Color(0xFFFAFFF8);
  static Color textFieldBorderColor = const Color(0xFFD7DDDB);

  static TextStyle textFieldLabelStyle = TextStyle(
    fontSize: 15,
    fontFamily: "Cabin",
    fontWeight: FontWeight.w500,
    color: springRainColor,
  );

  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 15,
    fontFamily: "Montaga",
    fontWeight: FontWeight.w500,
    color: camaroneColor,
  );

  static InputDecoration textFieldDecoration({
    required String labelText,
    String? errorText,
    String? iconPath,
    Size? iconSize,
    void Function()? onPressed,
  }) {
    return InputDecoration(
      constraints: BoxConstraints(
        maxHeight: (errorText != null) ? 51 : 42,
      ),
      contentPadding: const EdgeInsets.only(left: 12),
      suffixIcon: (iconPath == null)
          ? null
          : Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MaterialButton(
                onPressed: onPressed,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                shape: const CircleBorder(),
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(
                    AppTheme.springRainColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
      suffixIconConstraints: (iconPath == null)
          ? null
          : BoxConstraints.loose(
              iconSize ?? const Size(40, 35),
            ),
      labelText: labelText,
      labelStyle: AppTheme.textFieldLabelStyle,
      errorText: errorText,
      errorStyle: const TextStyle(
        height: 0.1,
        fontFamily: 'Cabin',
      ),
      filled: true,
      fillColor: AppTheme.textFieldFillColor,
      focusColor: AppTheme.textFieldFillColor,
      hoverColor: AppTheme.textFieldFillColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.textFieldBorderColor,
          strokeAlign: BorderSide.strokeAlignInside,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.textFieldBorderColor,
          strokeAlign: BorderSide.strokeAlignInside,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppTheme.textFieldBorderColor,
          strokeAlign: BorderSide.strokeAlignInside,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.shade900,
          strokeAlign: BorderSide.strokeAlignInside,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  ///
  ///
  /// Definition of [lightTheme] theme properties
  ///
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Montaga",
    brightness: Brightness.light,
    primaryColor: AppTheme.whiteColor,
    appBarTheme: AppBarTheme(
      surfaceTintColor: AppTheme.whiteColor,
      backgroundColor: AppTheme.whiteColor,
      scrolledUnderElevation: 0,
      shadowColor: const ColorScheme.light().shadow,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppTheme.whiteColor,
      surfaceTintColor: AppTheme.whiteColor,
    ),
    scaffoldBackgroundColor: AppTheme.whiteColor,
    primaryTextTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 16,
        color: AppTheme.blackColor,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppTheme.celadonGreenColor,
      selectionHandleColor: AppTheme.celadonGreenColor,
      selectionColor: AppTheme.celadonGreenColor.withOpacity(0.5),
    ),
  );

  ///
  ///
  /// Definition of [darkTheme] theme properties
  ///
  static ThemeData darkTheme = ThemeData(
    fontFamily: "Montaga",
    brightness: Brightness.dark,
    primaryColor: AppTheme.blackColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppTheme.blackColor,
      surfaceTintColor: AppTheme.blackColor,
      shadowColor: const ColorScheme.dark().shadow,
    ),
    scaffoldBackgroundColor: AppTheme.blackColor,
    primaryTextTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 16,
        color: AppTheme.whiteColor,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppTheme.christiColor,
      selectionHandleColor: AppTheme.christiColor,
      selectionColor: AppTheme.christiColor.withOpacity(0.5),
    ),
  );
}
