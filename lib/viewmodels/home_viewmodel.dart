import 'package:flutter_provider_mvvm/viewmodels/base_view_model.dart';
import 'package:flutter_provider_mvvm/viewmodels/view_state.dart';

class HomeViewModel extends BaseViewModel {
  int count = 10;

  loadData() async {
    setState(ViewState.loading);
    await Future.delayed(Duration(seconds: 2));
    count = 20;
    setState(ViewState.idle);
  }

  fav() {
    count += 10;
    notifyListeners();
  }
}
