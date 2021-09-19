import 'package:chart_flutter/ui/main_activity.dart';
import 'package:core/core.dart';
import 'package:shared/shared.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => inject<ThemeBloc>(),
        ),
        BlocProvider<ChartBloc>(
          create: (BuildContext context) => inject<ChartBloc>(),
        ),

      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    context.select((ThemeBloc themeBloc) => themeBloc.add(GetTheme()));
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: state.isDarkTheme ? Themes.darkTheme : Themes.lightTheme,

      initialRoute: MainScreen.routeName,
      routes: {

        MainScreen.routeName: (context) => const MainScreen(),

        //ErrorScreen.routeName: (context) => ErrorScreen(),

      },
    );
  }


}

