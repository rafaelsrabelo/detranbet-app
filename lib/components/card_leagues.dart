import 'package:detranbet/screens/games_page.dart';
import 'package:flutter/material.dart';
import 'package:detranbet/models/league.dart';
import 'package:detranbet/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';

class CardLeagues extends StatelessWidget {
  final List<League> leagues;

  const CardLeagues({
    Key? key,
    required this.leagues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: leagues.length,
      itemBuilder: (context, index) {
        final league = leagues[index];
        return InkWell(
          onTap: () async {
            print(league.key);
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GamePage(leagueKey: league.key),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Config.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                league.title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Config.primaryColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
