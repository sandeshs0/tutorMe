import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light/light.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _startListening();
  }

  StreamSubscription<int>? _lightSubscription;
  int _lastLuxValue = 100;
  void _startListening() {
    final lightSensor = Light();
    try {
      _lightSubscription = lightSensor.lightSensorStream.listen(
        (lux) {
          if ((lux < 10 && _lastLuxValue >= 10) ||
              (lux >= 10 && _lastLuxValue < 10)) {
            _lastLuxValue = lux;
            emit(lux < 10 ? ThemeMode.dark : ThemeMode.light);
            debugPrint("Theme Changed: ${lux < 10 ? 'Dark' : 'Light'} Mode");
          }
        },
        onError: (error) {
          debugPrint("Light sensor error: $error");
        },
      );
    } on Exception catch (e) {
      debugPrint('Failed to access light sensor: $e');
    }
  }

  @override
  Future<void> close() {
    _lightSubscription?.cancel();
    return super.close();
  }
}
