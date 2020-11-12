import 'package:flutter_provider_mvvm/models/user.dart';
import 'package:flutter_provider_mvvm/viewmodels/base_view_model.dart';
import 'package:flutter_provider_mvvm/viewmodels/view_state.dart';

class Api {
  User _loginUser;

  User get loginUser {
    return _loginUser;
  }

  Future<void> sensSms(String mobile) async {
    print('发送验证码...');
    await Future.delayed(Duration(seconds: 1));
    print('发送验证码成功');
  }

  /// 用户登录。简单起见，返回User
  Future<User> login(String mobile, String sms) async {
    print('登录中...');
    await Future.delayed(Duration(seconds: 1));
    User user = User(1, mobile);
    print('登录成功: $user');
    _loginUser = user;
    return user;
  }

  Future<User> homeData(String mobile, String smsCode) {
    // setState(ViewState.loading);
    Future.delayed(Duration(seconds: 2));
    // setState(ViewState.idle);

    User user = User(001, 'liaoyp');
    _loginUser = user;

    // notifyListeners();
    return Future.value(user);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'LoginUser: ${_loginUser?.name}';
  }
}
