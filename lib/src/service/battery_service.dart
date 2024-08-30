import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryService with ChangeNotifier, WidgetsBindingObserver {
  final Battery battery = Battery();
  BatteryState? batteryState;
  bool isFull = false;
  int batteryLevel = 100;

  BatteryService() {
    initBattery();
    WidgetsBinding.instance.addObserver(this);
  }

  void initBattery() async {
    batteryState = await battery.batteryState;
    await updateIsFull();
    battery.onBatteryStateChanged.listen((BatteryState state) {
      batteryState = state;
      updateIsFull();
      print(batteryState);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateBatteryLevel();
      print(AppLifecycleState);
    }
  }

  Future<void> updateBatteryLevel() async {
    batteryLevel = await battery.batteryLevel;
    notifyListeners();
  }

  Future<void> updateIsFull() async {
    await updateBatteryLevel();
    isFull = batteryLevel == 100;
    notifyListeners();
  }

  Future<void> updateTrue() async {
    await updateBatteryLevel();
    isFull = true;
    notifyListeners();
  }
}
