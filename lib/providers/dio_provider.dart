import 'package:dio/dio.dart';

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

      if (response.statusCode == 200 && response.data != '') {
        List<String>? authorizationHeaders = response.headers['authorization'];
        if (authorizationHeaders != null && authorizationHeaders.isNotEmpty) {
          String authorizationHeader = authorizationHeaders.first;
          if (authorizationHeader.startsWith('Bearer ')) {
            return authorizationHeader
                .substring(7);
          } else {
            return authorizationHeader;
          }
        }
      }
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
    return null;
  }

  Future<dynamic> updateOdds(String token) async {
    try {
      var response = await Dio().get(
        'https://my-bet-api.fly.dev/bet/update_games_and_odds',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print(response);
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
