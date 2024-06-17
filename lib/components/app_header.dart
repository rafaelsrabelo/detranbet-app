import 'package:detranbet/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppHeader extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onAvatarTap;

  const AppHeader({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.onAvatarTap,
  });

  String getInitials(String name) {
    List<String> names = name.split(' ');
    String initials = '';
    if (names.isNotEmpty) initials += names[0][0];
    if (names.length > 1) initials += names[1][0];
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text(
              userEmail,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: onAvatarTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Config.secondaryColor,
            child: Text(
              getInitials(userName),
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Config.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
