import 'package:atom_fan_control/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/fan.dart';

class AppState extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  ApiService api = ApiService();
  List<Fan> fans = [];
  bool loading = false;
  bool isDark = false;

  AppState() {
    loadSavedTokens();
  }

  Future<void> loadSavedTokens() async {
    final key = await storage.read(key: "apiKey");
    final refresh = await storage.read(key: "refresh");

    if (key != null && refresh != null) {
      api = ApiService(apiKey: key, refreshToken: refresh);
      fetchFans();
    }
  }

  Future<void> saveTokens(String key, String refresh) async {
    await storage.write(key: "apiKey", value: key);
    await storage.write(key: "refresh", value: refresh);
    api = ApiService(apiKey: key, refreshToken: refresh);
    fetchFans();
    notifyListeners();
  }

  Future<void> fetchFans() async {
    loading = true;
    notifyListeners();
   // fans = await api.getFans();
    loading = false;
    notifyListeners();
  }

  Future<void> togglePower(Fan fan) async {
    final ok = await api.setPower(fan.id, !fan.isOn);
    if (ok) {
      fan.isOn = !fan.isOn;
      notifyListeners();
    }
  }

  Future<void> changeSpeed(Fan fan, int speed) async {
    final ok = await api.setSpeed(fan.id, speed);
    if (ok) {
      fan.speed = speed;
      notifyListeners();
    }
  }
}
