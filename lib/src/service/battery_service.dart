import 'package:battery_plus/battery_plus.dart';
import 'package:battery_todo/src/service/battery_service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final batteryServiceProvider =
    NotifierProvider.autoDispose<BatteryService, BatteryServiceState?>(
        BatteryService.new);

class BatteryService extends Notifier<BatteryServiceState?>
    with WidgetsBindingObserver {
  @override
  BatteryServiceState? build() {
    initBattery(); // 배터리 초기화
    return state; // 초기 상태는 null
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
    // 더 이상 필요하지 않을 때 옵저버 제거
    WidgetsBinding.instance.removeObserver(this);
    // super.dispose(); 호출이 필요하지 않습니다. 직접 정리 작업만 수행합니다.
  }
}
