import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/mqtt_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MQTTController1 mqttController = Get.put(MQTTController1());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MQTT Test'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  mqttController.subscribe('myTopic');
                },
                child: Text('Subscribe to myTopic'),
              ),
              ElevatedButton(
                onPressed: () {
                  mqttController.unsubscribe('myTopic');
                },
                child: Text('Unsubscribe from myTopic'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
