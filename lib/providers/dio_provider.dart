import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  // get token
  Future<String?> getToken(String email, String password) async {
    try {
      var response = await Dio().post(
        'https://my-bet-api.fly.dev/login',
        data: {
          "player": {"email": email, "password": password}
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        List<String>? authorizationHeaders = response.headers['authorization'];
        if (authorizationHeaders != null && authorizationHeaders.isNotEmpty) {
          String authorizationHeader = authorizationHeaders.first;
          String token;
          if (authorizationHeader.startsWith('Bearer ')) {
            token = authorizationHeader.substring(7);
          } else {
            token = authorizationHeader;
          }

          // Save email and name to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String email = response.data['status']['data']['user']['email'];
          String name = response.data['status']['data']['user']['name'];
          await prefs.setString('email', email);
          await prefs.setString('name', name);

          return token;
        }
      }
    } catch (e) {
      print('Error during login: $e');
    }
    return null;
  }

  Future<dynamic> updateOdds(String token) async {
    try {
      var response = await Dio().get(
        'https://my-bet-api.fly.dev/bet/update_games_and_odds',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return response;
    } catch (e) {
      print('Error updating odds: $e');
      return null;
    }
  }

  Future<dynamic> getLeagues(String token) async {
    try {
      var response = await Dio().get(
        'https://my-bet-api.fly.dev/v2/leagues/',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      print(response);

      return response;
    } catch (e) {
      print('Error getting leagues: $e');
      return null;
    }
  }
}
