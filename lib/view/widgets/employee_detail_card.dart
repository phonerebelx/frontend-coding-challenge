import 'package:flutter/material.dart';
import 'package:frontend_coding_challenge/res/colors/colors.dart';
import 'package:frontend_coding_challenge/res/fonts/app_fonts.dart';
import 'package:frontend_coding_challenge/view/widgets/custom_button.dart';
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
  final VoidCallback? onGenerateICal;

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
    this.elevation = 4.0,
    this.onGenerateICal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardHeight = screenHeight * 0.66;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      width: screenWidth - 4,
      height: cardHeight,
      child: Card(
        elevation: elevation,
        color: backgroundColor,
        shadowColor: colors.orangeColor,
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

            // Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: memberName,
                      textColor: colors.blackColor,
                      fontSize: 24,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      fontFamily: AppFonts.manrope_semi_bold,
                    ),
                    const SizedBox(height: 2),
                    _buildInfoText("Type: $type"),
                    _buildInfoText("Period: $period"),
                    _buildInfoText("Status: $status"),

                    if (memberNote != null && memberNote!.trim().isNotEmpty) _buildInfoText("Member Note: $memberNote", maxLines: 2),
                    if (admitterNote != null && admitterNote!.trim().isNotEmpty) _buildInfoText("Admitter Note: $admitterNote", maxLines: 2),

                    const SizedBox(height: 8),

                    // Generate iCal Button
                    Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        height: 36,
                        width: 160,
                        title: "Generate iCal",
                        fontSize: 12,
                        textColor: Colors.white,
                        btnColor: colors.orangeColor,
                        borderRadius: BorderRadius.circular(8),
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        onTap: onGenerateICal,
                        isWidgetTrue: true,
                        customWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.calendar_month_outlined,
                                color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text(
                              "Generate iCal",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String text, {int maxLines = 1}) {
    return CustomText(
      text: text,
      textColor: colors.blackColor,
      fontSize: 16,
      height: 1.4,
      maxLines: maxLines,
      fontFamily: AppFonts.manrope_semi_bold,
    );
  }
}
