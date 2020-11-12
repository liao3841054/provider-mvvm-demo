import 'package:flutter/material.dart';
import 'package:flutter_provider_mvvm/api.dart';
import 'package:flutter_provider_mvvm/models/user.dart';
import 'package:flutter_provider_mvvm/route_paths.dart';
import 'package:flutter_provider_mvvm/viewmodels/home_viewmodel.dart';
import 'package:flutter_provider_mvvm/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _loginViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginViewModel?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _loginViewModel = Provider.of<LoginViewModel>(context, listen: true);
    debugPrint("_LoginViewState - build");

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('登录/注册'),
      ),
      body: Consumer<Api>(
        builder: (BuildContext context, Api api, Widget widget) {
          return _buildLoginContent(context);
        },
      ),
    );
  }

  Widget _buildLoginContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<int>(
              builder: (BuildContext context, int value, Widget child) {
                return Selector<int, int>(selector: (BuildContext c, int a) {
                  return a;
                }, builder: (BuildContext context, int value, Widget child) {
                  debugPrint('顶层的 Count - build');
                  return Container(
                    color: Colors.redAccent,
                    child: Text('===> $value'),
                  );
                }, shouldRebuild: (a, b) {
                  return false;
                });
              },
            ),
            _buildTitle(context),
            SizedBox(height: 30),
            _buildSignArea(context),
            SizedBox(height: 50),
            _buildLoginBtn(context),
            SizedBox(height: 16),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '用户登录',
          style: TextStyle(fontSize: 22),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Flutter MVVM 登录',
        )
      ],
    );
  }

  Widget _buildSignArea(BuildContext context) {
    return Container(
      width: 270,
      child: Column(
        children: <Widget>[
          _buildMobile(context),
          Container(
            height: 0.5,
            color: Color(0xFF6a6a6a),
          ),
          // Consumer<LoginViewModel>(
          //   builder:
          //       (BuildContext context, LoginViewModel value, Widget child) {
          //     return _buildSMS(context, value);
          //   },
          // ),
          _buildSMS(context, _loginViewModel),
          Container(
            height: 0.5,
            color: Color(0xFF6a6a6a),
          ),
        ],
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return TextField(
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.number,
      controller: _loginViewModel.mobileTextController,
      maxLength: 11,
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF191919),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        counterText: '',
        hintText: '请输入手机号',
        hintStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFFa5a5a5),
        ),
      ),
    );
  }

  Widget _buildSMS(BuildContext context, LoginViewModel _loginViewModel) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _loginViewModel.smsTextController,
            maxLength: 4,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF191919),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              hintText: '请输入短信验证码',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Color(0xFFa5a5a5),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            print('_loginViewModel $_loginViewModel');
            // Provider.of<LoginViewModel>(context, listen: false)
            //     .startCountDownTime();

            context.read<LoginViewModel>().startCountDownTime();
          },
          child: Text(
            _loginViewModel.countdownTimeText(),
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6a6a6a),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    return ButtonTheme(
      minWidth: 270,
      height: 45,
      buttonColor: Color(0xFF08ba07),
      child: RaisedButton(
        onPressed: () async {
          Api api = context.read<Api>();

          User user = await api.login(
              _loginViewModel.mobileTextController.text, 'userNamw2');
          Navigator.of(context).pushNamed(RoutePaths.HOME,
              arguments: {'mobile': user.name, 'sms': '9999'});
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Text(
          '登录',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
