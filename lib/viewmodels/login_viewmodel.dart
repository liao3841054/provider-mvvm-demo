import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_provider_mvvm/api.dart';
import 'package:flutter_provider_mvvm/models/user.dart';

import '../route_paths.dart';

class LoginViewModel extends ChangeNotifier {
  int _countdownTime = 0;

  String countdownTimeText() {
    return _countdownTime > 0 ? '$_countdownTime秒后重新发送' : '获取短信验证码';
  }

  Timer _timer;

  TextEditingController mobileTextController = TextEditingController();
  TextEditingController smsTextController = TextEditingController();

  startCountDownTime() {
    _countdownTime = 10;
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _countdownTime -= 1;
        if (_countdownTime < 0) {
          _countdownTime = 0;
          // _timer.cancel();
        }
        notifyListeners();
      });
    }
  }

  login(BuildContext context) async {
    User user =
        await Api().login(mobileTextController.text, smsTextController.text);

    Navigator.of(context).pushNamed(RoutePaths.HOME,
        arguments: {'mobile': user.name, 'sms': smsTextController.text});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mobileTextController?.dispose();
    smsTextController?.dispose();
    _timer?.cancel();

    super.dispose();
  }
}
