import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_provider_mvvm/route_paths.dart';
import 'package:flutter_provider_mvvm/views/change_provider.dart';
import 'package:flutter_provider_mvvm/views/consumer.dart';
import 'package:flutter_provider_mvvm/views/goods_fav.dart';
import 'package:flutter_provider_mvvm/views/home.dart';
import 'package:flutter_provider_mvvm/views/inherited.dart';
import 'package:flutter_provider_mvvm/views/login.dart';
import 'package:flutter_provider_mvvm/views/provider_of.dart';
import 'package:flutter_provider_mvvm/views/selecor.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutePaths.HOME:
        return MaterialPageRoute(
            builder: (_) => HomeView(arguments: settings.arguments));
      case RoutePaths.INHERITED:
        return MaterialPageRoute(builder: (_) => InheritedView());
      case RoutePaths.PROVIDER_OF:
        return MaterialPageRoute(builder: (_) => ProviderOfView());
      case RoutePaths.CONSUMER:
        return MaterialPageRoute(builder: (_) => ConsumerView());
      case RoutePaths.SELECTOR:
        return MaterialPageRoute(builder: (_) => SelectorView());
      case RoutePaths.CHANGE_NOTIFIER_PROVIDER:
        return MaterialPageRoute(builder: (_) => ChangeProviderOfView());
      case RoutePaths.GoodsListScreen:
        return MaterialPageRoute(builder: (_) => GoodsListScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('没有找到对应的页面：${settings.name}'),
                  ),
                ));
    }
  }
}
