import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart' as di;
import 'package:chart_flutter/chart_app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      )
  );

  Bloc.observer = ChartBlocObserver();

  await di.init(ApiConstants.HOST);

  runApp(const MyApp());

}
