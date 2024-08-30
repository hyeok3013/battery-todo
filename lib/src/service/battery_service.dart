import 'package:battery_plus/battery_plus.dart';
import 'package:battery_todo/src/service/battery_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final batteryServiceProvider =
    NotifierProvider.autoDispose<BatteryService, BatteryServiceState?>(
        BatteryService.new);

class BatteryService extends AutoDisposeNotifier<BatteryServiceState?>
    with WidgetsBindingObserver {
  @override
  BatteryServiceState? build() {
    // 초기 상태를 명시적으로 설정 (예: 배터리 정보를 가져오기 전 기본 값)
    state = BatteryServiceState(batteryLevel: 0, isFull: false);

    initBattery(); // 배터리 초기화 (비동기 작업)
    return state; // 초기 상태 반환
  }

  final Battery battery = Battery();

  BatteryService() {
    WidgetsBinding.instance.addObserver(this);
  }

  void initBattery() async {
    final level = await battery.batteryLevel;
    state = BatteryServiceState(batteryLevel: level, isFull: level == 100);

    battery.onBatteryStateChanged.listen((BatteryState state) {
      updateBatteryLevel();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateBatteryLevel();
    }
  }

  Future<void> updateBatteryLevel() async {
    final level = await battery.batteryLevel;
    state = state?.copyWith(batteryLevel: level, isFull: level == 100);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
