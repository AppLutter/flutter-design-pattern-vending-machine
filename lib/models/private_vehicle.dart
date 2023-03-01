import 'package:flutter/widgets.dart';

abstract class PrivateVehicle {
  const PrivateVehicle({
    required this.distance,
    required this.timesFaster,
    required this.speed,
    required this.name,
  });

  final double distance;
  final double timesFaster;
  final double speed;
  final String name;

  double calculateTakingTime();
  Widget showIcon();
}
