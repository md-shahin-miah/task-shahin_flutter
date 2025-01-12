// ignore_for_file: unnecessary_lambdas

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/device_info/device_info_service.dart';
import '../../services/logger/logger_service.dart';


final loggerServiceProvider = Provider<LoggerService>((ref) => LoggerService());
final deviceInfoServiceProvider = Provider<DeviceInfoService>((ref) => DeviceInfoService());

