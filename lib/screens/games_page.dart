import 'package:flutter/material.dart';
import 'package:detranbet/components/loader.dart';
import 'package:detranbet/models/game_model.dart';
import 'package:detranbet/providers/dio_provider.dart';
import 'package:detranbet/utils/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Importe o pacote intl para usar DateFormat

class GamePage extends StatefulWidget {
  final String leagueKey;

  GamePage({required this.leagueKey});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Game> games = [];

  @override
  void initState() {
    super.initState();
    print(widget.leagueKey);
    _fetchGames();
  }

  Future<void> _fetchGames() async {
    var leagueKeyId = widget.leagueKey;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      List<Game> fetchedGames =
          await DioProvider().getGames(token, leagueKeyId);

      setState(() {
        games = fetchedGames;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Config.backgroundColor,
        title: Text(
          'JOGOS POR LIGA',
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Config.backgroundColor,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: games.isNotEmpty
              ? ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (context, index) {
                    Game game = games[index];
                    return GameCard(game: game);
                  },
                )
              : Center(
                  child: Text(
                    'Não há jogos no momento',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Config.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Config.backgroundColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd/MM/yyyy HH:mm').format(game.commenceTime),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    game.homeTeam,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Config.primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    game.awayTeam,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Config.primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriceContainer("Casa", game.homePrice),
                const SizedBox(width: 8),
                _buildPriceContainer("Empate", game.drawPrice),
                const SizedBox(width: 8),
                _buildPriceContainer("Fora", game.awayPrice),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceContainer(String title, String price) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Config.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Config.secondaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
