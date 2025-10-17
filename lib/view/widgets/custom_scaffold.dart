// custom_scaffold.dart
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend_coding_challenge/res/assets/assets_conf.dart';
import 'package:frontend_coding_challenge/res/colors/colors.dart';
import 'package:get/get.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final EdgeInsets padding;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final ImageProvider? imageProvider;
  final List<Widget>? actions;
  final Color backgroundColor;
  final Color appBarColor;
  final Color iconThemeColor;
  final Color appBarTextColor;
  final Widget? drawer;
  final bool resizeToAvoidBottomInset;
  final bool showBackButton;
  final Widget? customLeading;
  final String? rightImage1;
  final Color rightImage1Color;
  final String? rightImage2;
  final VoidCallback? onRightImage1Pressed;
  final VoidCallback? onRightImage2Pressed;

  const CustomScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.padding = EdgeInsets.zero,
    this.backgroundColor = colors.whiteColor,
    this.appBarColor = colors.whiteColor,
    this.appBarTextColor = colors.blackColor,
    this.iconThemeColor = colors.greyColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.centerDocked,
    this.imageProvider,
    this.actions,
    this.drawer,
    this.resizeToAvoidBottomInset = false,
    this.showBackButton = true,
    this.customLeading,
    this.rightImage1,
    this.rightImage1Color = colors.whiteColor,
    this.rightImage2,
    this.onRightImage1Pressed,
    this.onRightImage2Pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: AppBar(
              surfaceTintColor: Colors.transparent,
            leading: showBackButton
                ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            )
                : customLeading ??
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                      ImageAssets.crewmeister,
                    fit: BoxFit.contain,
                  ),
                ),
            iconTheme: IconThemeData(color: iconThemeColor),
            backgroundColor: appBarColor,
            elevation: 0,
            title: AutoSizeText(
              title,
              maxLines: 1,
              wrapWords: false,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w700,
                color: appBarTextColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            flexibleSpace: imageProvider != null
                ? Opacity(
              opacity: 0.5,
              child: Image(
                image: imageProvider!,
                fit: BoxFit.cover,
              ),
            )
                : const SizedBox.shrink(),
            centerTitle: true,
            actions: actions ??
                [
                  if (rightImage1 != null || rightImage2 != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (rightImage1 != null)
                          IconButton(
                            icon: Image.asset(
                              rightImage1!,
                              color: rightImage1Color ,
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            onPressed: onRightImage1Pressed,
                          ),
                        if (rightImage1 != null && rightImage2 != null)
                          const SizedBox(width: 0),
                        if (rightImage2 != null)
                          IconButton(
                            icon: Image.asset(
                              rightImage2!,
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            onPressed: onRightImage2Pressed,
                          ),
                      ],
                    ),
                ],

          ),
        ),
        body: SafeArea(

          child: Padding(
            padding: padding,
            child: body,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        drawer: drawer,
      )

    );
  }
}