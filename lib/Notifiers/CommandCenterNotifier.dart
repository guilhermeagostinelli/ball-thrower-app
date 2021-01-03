import 'dart:async';
import 'package:ball_thrower_app/Config/Config.dart';
import 'package:ball_thrower_app/Enums/Speed.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:asuka/asuka.dart' as asuka;

class CommandCenterNotifier extends ChangeNotifier {
  Dio _dio = Dio(
    BaseOptions(
      baseUrl: Config.serverUrl,
      connectTimeout: 1000,
      receiveTimeout: 1000,
      sendTimeout: 1000,
    ),
  );
  bool _serverOn = false;
  bool _ballThrowerOn = false;
  Speed _feederSpeed = Speed.MEDIUM;
  Speed _shooterSpeed = Speed.MEDIUM;

  Future<void> _reconnectToServer() async {
    _serverOn = false;
    notifyListeners();
    await connectToServer();
  }

  Future<void> connectToServer() async {
    try {
      final Response res = await _dio.get(Config.serverUrl + '/status');
      _serverOn = res.statusCode == 200;
    } catch (_) {
      _serverOn = false;
    }
    if (!_serverOn) {
      await Future.delayed(const Duration(seconds: 2));
      return await connectToServer();
    }
    notifyListeners();
  }

  Future<bool> _sendCommandToServer(String path, String errActionMsg) async {
    try {
      final Response res = await _dio.get(Config.serverUrl + '/' + path);
      return res.statusCode == 200;
    } catch (err) {
      asuka.showDialog(
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(
            'An error occurred while trying to $errActionMsg:\n\n$err',
          ),
          actions: [
            FlatButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
      return false;
    }
  }

  set ballThrowerOn(bool isOn) {
    if (isOn) {
      Future.wait([
        _sendCommandToServer('feeder/start', 'start the feeder'),
        _sendCommandToServer('shooter/start', 'start the shooter'),
      ]).then((responses) {
        if (!responses.every((r) => r)) return _reconnectToServer();
        _ballThrowerOn = true;
        notifyListeners();
      });
    } else {
      Future.wait([
        _sendCommandToServer('feeder/stop', 'stop the feeder'),
        _sendCommandToServer('shooter/stop', 'stop the shooter'),
      ]).then((responses) {
        if (!responses.every((r) => r)) return _reconnectToServer();
        _ballThrowerOn = false;
        _feederSpeed = Speed.MEDIUM;
        _shooterSpeed = Speed.MEDIUM;
        notifyListeners();
      });
    }
  }

  set feederSpeed(Speed speed) {
    _sendCommandToServer(
      'feeder/change-speed/${speed.valueOf}',
      'change the feeder speed',
    ).then((r) {
      if (!r) return _reconnectToServer();
      _feederSpeed = speed;
      notifyListeners();
    });
  }

  set shooterSpeed(Speed speed) {
    _sendCommandToServer(
      'shooter/change-speed/${speed.valueOf}',
      'change the shooter speed',
    ).then((r) {
      if (!r) return _reconnectToServer();
      _shooterSpeed = speed;
      notifyListeners();
    });
  }

  get ballThrowerOn => _ballThrowerOn;

  get feederSpeed => _feederSpeed;

  get shooterSpeed => _shooterSpeed;

  get serverOn => _serverOn;
}
