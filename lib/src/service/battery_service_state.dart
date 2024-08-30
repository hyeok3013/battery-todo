class BatteryServiceState {
  final int batteryLevel;
  final bool isFull;

  BatteryServiceState({
    required this.batteryLevel,
    required this.isFull,
  });

  BatteryServiceState copyWith({
    int? batteryLevel,
    bool? isFull,
  }) {
    return BatteryServiceState(
      batteryLevel: batteryLevel ?? this.batteryLevel,
      isFull: isFull ?? this.isFull,
    );
  }
}
