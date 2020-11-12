import 'package:flutter/foundation.dart';
import 'package:flutter_provider_mvvm/viewmodels/view_state.dart';

class BaseViewModel extends ChangeNotifier {
  bool _disposed = false;

  ViewState _viewState = ViewState.idle;

  ViewState get viewState {
    return _viewState;
  }

  void setState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
