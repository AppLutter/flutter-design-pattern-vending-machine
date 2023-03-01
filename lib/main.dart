import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_design_pattern_vending_machine/adapter/airplane_adapter.dart';
import 'package:flutter_design_pattern_vending_machine/adapter/train_adapter.dart';
import 'package:flutter_design_pattern_vending_machine/const.dart';
import 'package:flutter_design_pattern_vending_machine/models/car.dart';
import 'package:flutter_design_pattern_vending_machine/models/private_vehicle.dart';
import 'package:flutter_design_pattern_vending_machine/shared_pref.dart';
import 'package:flutter_design_pattern_vending_machine/vehicle_tile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController controller;
  List<PrivateVehicle> vehicles = [];
  double distance = 0.0;
  double timesFaster = 1.0;

  @override
  void initState() {
    super.initState();
    final String? initialTimesFaster = SharedPrefs.instance.getString(timeFasterKey);
    generateTile();
    timesFaster = initialTimesFaster == null ? 1.0 : double.parse(initialTimesFaster);
    controller = TextEditingController();
  }

  void generateTile() {
    vehicles = [
      Car(timesFaster: timesFaster, distance: distance),
      AirplaneAdapter(timesFaster: timesFaster, distance: distance),
      TrainAdapter(timesFaster: timesFaster, distance: distance),
    ];
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    const appBarTitle = Text('시간 계산기');
    const inputLabel = Text('거리를 입력하세요');

    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      final dis = double.parse(value);
                      setState(() {
                        distance = dis;
                      });
                      generateTile();
                    } else {
                      setState(() {
                        distance = 0;
                      });
                    }
                  },
                  maxLength: 4,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[1-9]\d{0,3}$')),
                  ],
                  decoration: InputDecoration(
                    label: inputLabel,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.lightBlueAccent.withOpacity(0.5),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 25.0),
                const Text('배속'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    fasterButton(
                        text: '-0.1',
                        onPressed: () {
                          setState(() {
                            timesFaster -= 0.1;
                          });
                          generateTile();
                        }),
                    Text(timesFaster.toStringAsFixed(1)),
                    fasterButton(
                        text: '+0.1',
                        onPressed: () {
                          setState(() {
                            timesFaster += 0.1;
                          });
                          generateTile();
                        }),
                  ],
                ),
                const SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: vehicles.map((vehicle) => VehicleTile(vehicle: vehicle)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fasterButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: () {
        if (timesFaster < 0.2) {
          return;
        }
        onPressed();
        SharedPrefs.instance.setString(timeFasterKey, timesFaster.toString());
      },
      child: Text(text),
    );
  }
}
