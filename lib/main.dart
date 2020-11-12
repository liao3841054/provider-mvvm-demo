import 'package:flutter/material.dart';
import 'package:flutter_provider_mvvm/router.dart';
import 'package:flutter_provider_mvvm/services/setup_services.dart';
import 'package:provider/provider.dart';

import 'route_paths.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: prioviders,
      child: MaterialApp(
        title: 'Provider 学习',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RoutePaths.PROVIDER_OF,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
