import 'package:flutter/material.dart';

extension CustomColor on ThemeData {
  Color get colorGreyCard => const Color.fromRGBO(249, 249, 249, 1);

  Color get colorBorder => const Color.fromRGBO(172, 171, 171, 1);

  Color get baseColorShimmer => Colors.grey[300]!;
  Color get colorRed => const Color.fromRGBO(232, 49, 49, 1);
  Color get buttonSecondary => const Color.fromRGBO(69, 95, 231, 1);
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension CustomTextTheme on TextTheme {
  TextStyle get subHead1 => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);

  TextStyle get subHead2 => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black);

  TextStyle get subHead3 => const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black);

  TextStyle get subHead4 => const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w500, color: Colors.black);

  TextStyle get textLink => TextStyle(
      fontSize: 14, fontWeight: FontWeight.w500, color: impackAccentColor[200]);

  TextStyle get paragraph1 => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);

  TextStyle get paragraph2 => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);

  TextStyle get paragraph3 => const TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black);

  TextStyle get paragraph4 => const TextStyle(
      fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black);

  TextStyle get textButton => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);

  TextStyle get textButtonActive => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

  TextStyle get statusCancelled => const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(232, 49, 49, 1));

  TextStyle get statusDelivered => const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(76, 175, 80, 1));

  TextStyle get cancelled => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(232, 49, 49, 1));

  TextStyle get delivered => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(76, 175, 80, 1));

  TextStyle get onProgress => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: impackAccentColor[200],
      );

  TextStyle get textPrice => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: impackAccentColor[200],
      );

  TextStyle get textButtonRed => const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(232, 49, 49, 1));

  TextStyle get textButtonBlue => const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(88, 90, 255, 1));
}

const MaterialColor impackColor = MaterialColor(
  impackPrimaryColor,
  <int, Color>{
    50: Color(0xFFE0E3F1),
    100: Color(0xFFB3B9DC),
    200: Color(0xFF808BC4),
    300: Color(0xFF4D5CAC),
    400: Color(0xFF26399B),
    500: Color(impackPrimaryColor),
    600: Color(0xFF001381),
    700: Color(0xFF001076),
    800: Color(0xFF000C6C),
    900: Color(0xFF000659),
  },
);

const int impackPrimaryColor = 0xFF074869;

const MaterialColor impackAccentColor = MaterialColor(
  _impackAccentValue,
  <int, Color>{
    100: Color(0xFF8B8CFF),
    200: Color(_impackAccentValue),
    400: Color(0xFF2528FF),
    700: Color(0xFF0B0FFF),
  },
);
const int _impackAccentValue = 0xFF585AFF;

ThemeData getThemeData() {
  Color? dividerColor = const Color(0xFFACABAB);
  Color? backgroundColor = Colors.white;
  return ThemeData(
    primaryColor: const Color(impackPrimaryColor),
    dividerColor: dividerColor,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      titleLarge: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      toolbarHeight: 34,
      backgroundColor: backgroundColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.hardEdge,
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      height: 60,
      backgroundColor: Colors.white,
      indicatorColor: Colors.white,
      iconTheme: MaterialStateProperty.all(
        const IconThemeData(color: Color(0xFFACABAB), size: 24),
      ),
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
      ),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle?>(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color?>(
          impackColor[impackPrimaryColor],
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size(0, 0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: impackColor)
        .copyWith(background: backgroundColor)
        .copyWith(error: Colors.red),
  );
}
