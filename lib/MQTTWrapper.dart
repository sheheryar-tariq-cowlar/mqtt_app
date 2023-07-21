import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClientWrapper {
  late MqttServerClient client;

  final void Function(String?)? onReceived;
  final void Function()? onConnected;
  final void Function()? onDisconnected;
  final void Function(String?)? onSubscribed;
  final void Function(String?)? onSubscribeFail;
  final void Function(String?)? onUnsubscribed;
  final void Function()? onPong;

  MqttClientWrapper({
    this.onReceived,
    this.onConnected,
    this.onDisconnected,
    this.onSubscribed,
    this.onSubscribeFail,
    this.onUnsubscribed,
    this.onPong,
  });

  void prepareMqttClient(String server) {
    _setupMqttClient();
    _connectToServer(server);
  }

  void _setupMqttClient() {
    client = MqttServerClient('test.mosquitto.org', 'flutter_client');
    client.port = 1883;
    client.logging(on: true);

    client.keepAlivePeriod = 60;
    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .keepAliveFor(60)
        .withWillTopic('willtopic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.onUnsubscribed = onUnsubscribed;
    client.pongCallback = onPong;
  }

  void _connectToServer(String server) {
    try {
      client.connect();
      client.updates?.listen((c) {
        debugPrint("Hello World");
        final MqttMessage message = c[0].payload;
        final payload = MqttPublishPayload.bytesToStringAsString(
            (message as MqttPublishMessage).payload.message);
        print(
            "..............................................................................................");
        print(payload);
      });
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    }
  }

  void connect() {
    client.connect();
  }

  void disconnect() {
    client.disconnect();
  }

  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void unsubscribe(String topic) {
    client.unsubscribe(topic, expectAcknowledge: true);
  }
}
