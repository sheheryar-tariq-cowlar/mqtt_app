import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mqtt_app/MQTTWrapper.dart' show MqttClientWrapper;

// class MQTTController extends GetxController {
//   Future<MqttServerClient> connect() async {
//     // connection succeeded
//     void onConnected() {
//       print('Connected');
//     }

// // unconnected
//     void onDisconnected() {
//       print('Disconnected');
//     }

// // subscribe to topic succeeded
//     void onSubscribed(String topic) {
//       print('Subscribed topic: $topic');
//     }

// // subscribe to topic failed
//     void onSubscribeFail(String topic) {
//       print('Failed to subscribe $topic');
//     }

// // unsubscribe succeeded
//     void onUnsubscribed(String topic) {
//       print('Unsubscribed topic: $topic');
//     }

// // PING response received
//     void pong() {
//       print('Ping response client callback invoked');
//     }

//     MqttServerClient client =
//         MqttServerClient.withPort('broker.emqx.io', 'flutter_client', 1883);
//     client.logging(on: true);
//     client.onConnected = onConnected;
//     client.onDisconnected = onDisconnected;
//     client.onUnsubscribed = onUnsubscribed as UnsubscribeCallback?;
//     client.onSubscribed = onSubscribed;
//     client.onSubscribeFail = onSubscribeFail;
//     client.pongCallback = pong;

//     final connMessage = MqttConnectMessage()
//         .authenticateAs('username', 'password')
//         .keepAliveFor(60)
//         .withWillTopic('willtopic')
//         .withWillMessage('Will message')
//         .startClean()
//         .withWillQos(MqttQos.atLeastOnce);
//     client.connectionMessage = connMessage;
//     try {
//       await client.connect();
//     } catch (e) {
//       print('Exception: $e');
//       client.disconnect();
//     }

//     client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
//       final MqttMessage message = c[0].payload;

//       final payload = MqttPublishPayload.bytesToStringAsString(
//         (message as MqttPublishMessage).payload.message,
//       );

//       print('Received message:$payload from topic: ${c[0].topic}>');
//     });

//     return client;
//   }
// }

class MQTTController1 extends GetxController {
  late MqttClientWrapper mqttClientWrapper;

  @override
  void onInit() {
    super.onInit();
    mqttClientWrapper = MqttClientWrapper(
      onConnected: onConnected,
      onDisconnected: onDisconnected,
      onSubscribed: (topic) => handleOnSubscribed(topic),
      onSubscribeFail: (topic) => handleOnSubscribeFail(topic),
      onUnsubscribed: (topic) => handleOnUnsubscribed(topic),
      onPong: handlePong,
      onReceived: (message) => handleOnReceived(message),
    );
    mqttClientWrapper.prepareMqttClient('test.mosquitto.org');
  }

  void onConnected() {
    print('Connected to MQTT broker');
  }

  void onDisconnected() {
    print('Disconnected from MQTT broker');
  }

  void handlePong() {
    print('Pong received');
  }

  void connect() {
    mqttClientWrapper.connect();
  }

  void disconnect() {
    mqttClientWrapper.disconnect();
  }

  void subscribe(String topic) {
    mqttClientWrapper.subscribe(topic);
  }

  void unsubscribe(String topic) {
    mqttClientWrapper.unsubscribe(topic);
  }

  void handleOnConnected() {
    print('Connected');
  }

  void handleOnDisconnected() {
    print('Disconnected');
  }

  void handleOnSubscribed(String? topic) {
    if (topic != null) {
      print('Subscribed to topic: $topic');
    } else {
      print('Subscribed to an unknown topic');
    }
  }

  void handleOnSubscribeFail(String? topic) {
    if (topic != null) {
      print('Failed to subscribe to topic: $topic');
    } else {
      print('Failed to subscribe to an unknown topic');
    }
  }

  void handleOnUnsubscribed(String? topic) {
    if (topic != null) {
      print('Unsubscribed from topic: $topic');
    } else {
      print('Unsubscribed from an unknown topic');
    }
  }

  void handleOnReceived(String? message) {
    if (message != null) {
      print('Received message: $message');
    } else {
      print('Received an empty message');
    }
  }
}
