import 'package:flutter/material.dart';
import 'package:flutter_design_pattern_vending_machine/models/private_vehicle.dart';

class Car extends PrivateVehicle {
  Car({
    super.speed = 100.0,
    required super.timesFaster,
    required super.distance,
    super.name = '자동차',
  });

  @override
  double calculateTakingTime() {
    return distance / (speed * timesFaster) * 60;
  }

  @override
  Widget showIcon() {
    return const Icon(Icons.car_crash_sharp);
  }
}
