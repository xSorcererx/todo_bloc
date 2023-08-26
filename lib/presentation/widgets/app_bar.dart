import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_bloc/presentation/utils/size_constants.dart';

// Custom app bar for the app, which could be used for all screens

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Row(
        children: [
          const Icon(
            Icons.person_rounded,
            color: Colors.white,
            size: 24,
          ),
          SBC.lW,
          Text(
            'Anish Shrestha',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 18,
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                  color: Colors.white,
                ),
          ),
        ],
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.notifications,
            size: 23,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
