import 'package:flutter/material.dart';
import 'package:frontend_coding_challenge/res/colors/colors.dart';
import 'package:frontend_coding_challenge/res/fonts/app_fonts.dart';
import 'package:frontend_coding_challenge/view/widgets/employee_card_image.dart';
import 'package:frontend_coding_challenge/view/widgets/custom_text.dart';

class EmployeeDetailCard extends StatelessWidget {
  final String? imageUrl;
  final String memberName;
  final String type;
  final String period;
  final String status;
  final String? memberNote;
  final String? admitterNote;
  final Color backgroundColor;
  final double borderRadius;
  final double elevation;

  const EmployeeDetailCard({
    Key? key,
    this.imageUrl,
    required this.memberName,
    required this.type,
    required this.period,
    required this.status,
    this.memberNote,
    this.admitterNote,
    this.backgroundColor = colors.whiteColor,
    this.borderRadius = 12.0,
    this.elevation = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardHeight = screenHeight * 0.56;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      width: screenWidth - 4,
      height: cardHeight,
      child: Card(
        elevation: elevation,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Image Section
            EmployeeCardImage(
              imageUrl: imageUrl,
              height: cardHeight * 0.5,
              borderRadius: borderRadius - 2,
            ),

            // Bottom Section
            Expanded(
              child: Container(
                width: double.infinity,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: memberName,
                        textColor: colors.blackColor,
                        fontSize: 24,
                        height:1.6,
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        fontFamily: AppFonts.manrope_semi_bold,
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        text: "Type: $type",
                        textColor: colors.blackColor,
                        fontSize: 16,
                        height:1.4,
                        fontFamily: AppFonts.manrope_semi_bold,
                      ),
                      CustomText(
                        text: "Period: $period",
                        textColor: colors.blackColor,
                        fontSize: 16,
                        height:1.4,
                        fontFamily: AppFonts.manrope_semi_bold,
                      ),
                      CustomText(
                        text: "Status: $status",
                        textColor: colors.blackColor,
                        fontSize: 16,
                        height:1.4,
                        fontFamily: AppFonts.manrope_semi_bold,
                      ),
                      if (memberNote != null)
                        CustomText(
                          text: "Member Note: $memberNote",
                          textColor: colors.blackColor,
                          fontSize: 16,
                          height:1.4,
                          maxLines: 2,
                          fontFamily: AppFonts.manrope_semi_bold,
                        ),
                      if (admitterNote != null)
                        CustomText(
                          text: "Admitter Note: $admitterNote",
                          textColor: colors.blackColor,
                          fontSize: 16,
                          height:1.4,
                          maxLines: 2,
                          fontFamily: AppFonts.manrope_semi_bold,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
