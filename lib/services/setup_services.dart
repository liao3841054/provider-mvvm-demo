import 'package:flutter_provider_mvvm/api.dart';
import 'package:flutter_provider_mvvm/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> prioviders = [
  ...independentServices,
  ...dependentServices
];

List<SingleChildWidget> independentServices = [
  Provider(create: (_) => Api()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  Provider.value(value: 1000),
];

List<SingleChildWidget> dependentServices = [];
