import 'package:flutter/material.dart';
import 'package:flutter_design_pattern_vending_machine/const.dart';
import 'package:flutter_design_pattern_vending_machine/models/private_vehicle.dart';
import 'package:flutter_design_pattern_vending_machine/models/train.dart';

class TrainAdapter extends PrivateVehicle {
  late Train _train;

  TrainAdapter({
    super.speed = 300,
    required super.timesFaster,
    required super.distance,
    super.name = '기차',
  }) {
    _train = Train(speedMile: speed * mileToKilo);
  }

  @override
  double calculateTakingTime() {
    return (distance / (_train.speedMile * timesFaster)) * 60 + _train.averageDelayMin;
  }

  @override
  Widget showIcon() {
    return const Icon(Icons.train);
  }
}
