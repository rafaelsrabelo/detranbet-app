import 'package:detranbet/components/loader.dart';
import 'package:detranbet/main.dart';
import 'package:detranbet/models/game_model.dart';
import 'package:detranbet/models/league.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  Future<bool> createUser(String email, String name, String password) async {
    try {
      Loader.show();
      var response = await Dio().post(
        'https://my-bet-api.fly.dev/signup',
        data: {
          "player": {"email": email, "name": name, "password": password}
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return true; // Signup successful
      }
    } catch (e) {
      print('Error during signup: $e');
    } finally {
      Loader.hide();
    }
    return false; // Signup failed
  }

  // get token
  Future<String?> getToken(String email, String password) async {
    try {
      Loader.show();
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
          String tokenAccess = token;
          String email = response.data['status']['data']['user']['email'];
          String name = response.data['status']['data']['user']['name'];

          await prefs.setString('token', tokenAccess);
          await prefs.setString('email', email);
          await prefs.setString('name', name);

          return token;
        }
      }
    } catch (e) {
      print('Error during login: $e');
    } finally {
      Loader.hide();
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

  Future<List<League>> getLeagues(String token) async {
    try {
      // Loader.show();
      var response = await Dio().get(
        'https://my-bet-api.fly.dev/v2/leagues/',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200 && response.data != null) {
        List<dynamic> leaguesJson = response.data;
        return leaguesJson.map((json) => League.fromJson(json)).toList();
      }
    } catch (e) {
      if (e is DioError &&
          e.response != null &&
          e.response!.statusCode == 401) {
        // Unauthorized: logout and redirect to '/'
        await logout(token);
        MyApp.navigatorKey.currentState!.pushNamed('auth');
      } else {
        print('Error getting leagues: $e');
      }
    } finally {
      Loader.hide();
    }
    return [];
  }

  // Future<void> _logoutAndRedirect() async {}

  Future<List<Game>> getGames(String token, String leagueKey) async {
    try {
      Loader.show();
      var response = await Dio().get(
        'https://my-bet-api.fly.dev/v2/odds/$leagueKey',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.statusCode == 200) {
        List<dynamic> gamesJson = response.data;
        return gamesJson.map((json) => Game.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        await logout(token);
        MyApp.navigatorKey.currentState!.pushNamed('auth');
      }
    } catch (e) {
      print('Error getting games: $e');
    } finally {
      Loader.hide();
    }
    return [];
  }

  Future<void> logout(String token) async {
    try {
      Loader.show();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      // }
    } catch (e) {
      print('Error during logout: $e');
    } finally {
      Loader.hide();
    }
  }
}
