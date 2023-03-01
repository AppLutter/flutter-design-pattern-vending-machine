import 'package:flutter/material.dart';
import 'package:flutter_design_pattern_vending_machine/models/private_vehicle.dart';

class VehicleTile extends StatelessWidget {
  const VehicleTile({
    Key? key,
    required this.vehicle,
  }) : super(key: key);
  final PrivateVehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final time = vehicle.calculateTakingTime();
    final calcTime = time.isNaN ? '0.0' : '${time.toStringAsFixed(2)} 분';

    return Column(
      children: [
        vehicle.showIcon(),
        const SizedBox(height: 5.0),
        Text(vehicle.name),
        const SizedBox(height: 10.0),
        Text(calcTime),
      ],
    );
  }
}
