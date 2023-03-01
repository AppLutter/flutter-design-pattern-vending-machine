import 'package:flutter/material.dart';
import 'package:flutter_design_pattern_vending_machine/const.dart';
import 'package:flutter_design_pattern_vending_machine/models/airplane.dart';
import 'package:flutter_design_pattern_vending_machine/models/private_vehicle.dart';

class AirplaneAdapter extends PrivateVehicle {
  late Airplane _airplane;

  AirplaneAdapter({
    super.speed = 500,
    required super.timesFaster,
    required super.distance,
    super.name = '비행기',
  }) {
    _airplane = Airplane(speedKnot: super.speed * knotToKilo);
  }

  @override
  double calculateTakingTime() {
    return (distance / (_airplane.speedKnot*timesFaster)) + (_airplane.averageDelayHour * 60);
  }

  @override
  Widget showIcon() {
    return const Icon(Icons.airplane_ticket_rounded);
  }
}
