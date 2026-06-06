import 'package:flutter/material.dart';
import 'package:overcloud/main_common.dart';
import 'package:overcloud/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppEnvironment.setUpEnv(Environment.prod);

  mainCommon();
}