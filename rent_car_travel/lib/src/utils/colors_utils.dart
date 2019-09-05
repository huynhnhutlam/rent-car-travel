import 'package:flutter/material.dart';

export 'package:flutter/services.dart' show Brightness;

class AppColor {
  factory AppColor({
    Brightness brightness,
    // Background color
    Color mainBg,
    Color primaryBg,
    Color primaryDark,
    Color hideBg,
    Color lineBg,
    Color blackBg,
    Color iconBgActive,
    Color iconBg,
    Color iconBgDark,
    Color tabBarBg,
    Color listBg,
    Color highLightBg,

    // TextColor
    Color primaryText,
    Color mainText,
    Color buttonText,
    Color subText,
    Color errorText,
    Color highlightText,
    Color disableText,
    Color whiteText,
    Color toolbarText,

    // Button background
    Color normalButton,
    Color hightlightButton,
    Color disableButton
  }) {
    brightness ??= Brightness.light;
    final bool isDark = brightness == Brightness.dark;
    // Backround
    mainBg ??= isDark ? Color(0xFFFAFAFA) : Color(0xFFFAFAFA);
    primaryBg ??= isDark ? Color(0xFFCFE82A) : Color(0xFFCFE82A);
    primaryDark ??= isDark ? Color(0xFF8CC63F) : Color(0xFF8CC63F);
    hideBg ??= isDark ? Color(0xFF393939) : Color(0xFF393939);
    lineBg ??= isDark ? Color(0xFF000000) : Color(0xFF000000);
    blackBg ??= isDark ? Color(0xFF000000) : Color(0xFF000000);
    iconBgActive ??= isDark ? Color(0xFF97C93B) : Color(0xFF97C93B);
    iconBg ??= isDark ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
    iconBgDark ??= isDark ? Color(0xFFB2B2B2) : Color(0xFFB2B2B2);
    tabBarBg ??= isDark ? Color(0xFF8CC63F) : Color(0xFF8CC63F);
    listBg ??= isDark ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
    highLightBg ??= isDark ? Color(0xFFFF9D00) : Color(0xFFFF9D00);
    // Text
    primaryText ??= isDark ? Color(0xFF8CC63F) : Color(0xFF8CC63F);
    mainText ??= isDark ? Color(0xFF232323) : Color(0xFF232323);
    buttonText ??= isDark ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
    subText ??= isDark ? Color(0xFFB2B2B2) : Color(0xFFB2B2B2);
    errorText ??= isDark ? Color(0xFFED0000) : Color(0xFFED0000);
    highlightText ??= isDark ? Color(0xFFFF9D00) : Color(0xFFFF9D00);
    disableText ??= isDark ? Color(0xFF969696) : Color(0xFF969696);
    whiteText ??= isDark ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
    toolbarText ??= isDark ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);
    // Button
    normalButton ??= isDark ? Color(0xFFCFE82A) : Color(0xFFCFE82A);
    hightlightButton ??= isDark ? Color(0xFF8CC63F) : Color(0xFF8CC63F);
    disableButton ??= isDark ? Color(0xFF969696) : Color(0xFF969696);

    return AppColor.raw(
      brightness: brightness,
      mainBg: mainBg,
      primaryBg: primaryBg,
      primaryDark: primaryDark,
      hideBg: hideBg,
      lineBg: lineBg,
      blackBg: blackBg,
      iconBgActive: iconBgActive,
      iconBg: iconBg,
      iconBgDark: iconBgDark,
      tabBarBg: tabBarBg,
      listBg: listBg,
      highLightBg: highLightBg,
      primaryText: primaryText,
      mainText: mainText,
      buttonText: buttonText,
      subText: subText,
      errorText: errorText,
      highlightText: highlightText,
      disableText: disableText,
      whiteText: whiteText,
      toolbarText: toolbarText,
      normalButton: normalButton,
      hightlightButton: hightlightButton,
      disableButton: disableButton,
    );
  }

  const AppColor.raw ({
    @required this.brightness,
    @required this.mainBg,
    @required this.primaryBg,
    @required this.primaryDark,
    @required this.hideBg,
    @required this.lineBg,
    @required this.blackBg,
    @required this.iconBgActive,
    @required this.iconBg,
    @required this.iconBgDark,
    @required this.tabBarBg,
    @required this.listBg,
    @required this.highLightBg,
    @required this.primaryText,
    @required this.mainText,
    @required this.buttonText,
    @required this.subText,
    @required this.errorText,
    @required this.highlightText,
    @required this.disableText,
    @required this.whiteText,
    @required this.toolbarText,
    @required this.normalButton,
    @required this.hightlightButton,
    @required this.disableButton,
    
  }) : 
  assert(brightness != null),
  assert(mainBg != null),
  assert(primaryBg != null),
  assert(primaryDark != null),
  assert(hideBg != null),
  assert(lineBg != null),
  assert(iconBgActive != null),
  assert(iconBg != null),
  assert(iconBgDark != null),
  assert(tabBarBg != null),
  assert(listBg != null),
  assert(highLightBg != null),
  assert(primaryText != null),
  assert(mainText != null),
  assert(buttonText != null),
  assert(subText != null),
  assert(errorText !=null),
  assert(whiteText != null),
  assert(highlightText != null),
  assert(disableText != null),
  assert(toolbarText != null),
  assert(normalButton != null),
  assert(hightlightButton != null),
  assert(disableButton != null),
  assert(normalButton != null);

  final Brightness brightness;
  // Background color
  final Color mainBg;
  final Color primaryBg;
  final Color primaryDark;
  final Color hideBg;
  final Color lineBg;
  final Color blackBg;
  final Color iconBgActive;
  final Color iconBg;
  final Color iconBgDark;
  final Color tabBarBg;
  final Color listBg;
  final Color highLightBg;

  // TextColor
  final Color primaryText;
  final Color mainText;
  final Color buttonText;
  final Color subText;
  final Color errorText;
  final Color highlightText;
  final Color disableText;
  final Color whiteText;
  final Color toolbarText;

  // Button background
  final Color normalButton;
  final Color hightlightButton;
  final Color disableButton;
}