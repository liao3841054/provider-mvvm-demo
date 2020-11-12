import 'package:flutter/material.dart';
import 'package:flutter_provider_mvvm/api.dart';
import 'package:flutter_provider_mvvm/viewmodels/base_view_widget.dart';
import 'package:flutter_provider_mvvm/viewmodels/home_viewmodel.dart';
import 'package:flutter_provider_mvvm/viewmodels/view_state.dart';
import 'package:provider/provider.dart';

import '../route_paths.dart';

class HomeView extends StatefulWidget {
  final Map arguments;

  const HomeView({Key key, this.arguments}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
//
// class HomeView extends StatelessWidget {

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // HomeViewModel model = context.watch<HomeViewModel>();
    print("home build===");

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('首页'),
        ),
        body: Builder(
          builder: (context) => Center(
              child: Column(
            children: <Widget>[
              Text('APP首页 ${widget.arguments['mobile']} '),
              Consumer<int>(
                builder: (BuildContext context, int value, Widget child) {
                  print("Container build===");

                  return Container(
                    color: Colors.redAccent,
                    child: Text('===> $value'),
                  );
                },
              ),
              Consumer<Api>(
                builder: (BuildContext context, Api value, Widget child) {
                  print("Container build===");

                  return Container(
                    color: Colors.redAccent,
                    child: Text('===> ${value.loginUser.name}'),
                  );
                },
              ),
              BaseViewModelWidget(
                model: HomeViewModel(),
                onModelReady: (HomeViewModel model) {
                  model.loadData();
                },
                builder:
                    (BuildContext context, HomeViewModel model, Widget widget) {
                  print("builder:===><");
                  return Builder(
                      builder: (context) => Center(
                          child: model.viewState == ViewState.loading
                              ? CircularProgressIndicator()
                              : Column(
                                  children: <Widget>[
                                    // Text('APP首页 ${widget.arguments['mobile']} '),
                                    Text('APP首页 ${model?.count} '),
                                    FlatButton(
                                      onPressed: () {
                                        model.fav();
                                      },
                                      child: Text('点击'),
                                    ),
                                  ],
                                )));
                },
              ),
              BaseViewModelWidget(
                model: HomeViewModel(),
                onModelReady: (HomeViewModel model) {
                  model.loadData();
                },
                builder:
                    (BuildContext context, HomeViewModel model, Widget widget) {
                  print("builder:===><");
                  return Builder(
                      builder: (context) => Center(
                          child: model.viewState == ViewState.loading
                              ? CircularProgressIndicator()
                              : Column(
                                  children: <Widget>[
                                    // Text('APP首页 ${widget.arguments['mobile']} '),
                                    Text('222APP首页 ${model?.count} '),
                                    FlatButton(
                                      onPressed: () {
                                        model.fav();
                                        Navigator.of(context).pushNamed(
                                          RoutePaths.GoodsListScreen,
                                        );
                                      },
                                      child: Text('点击222'),
                                    ),
                                  ],
                                )));
                },
              ),
            ],
          )),
        ));

    // return BaseViewModelWidget(
    //   model: HomeViewModel(),
    //   onModelReady: (HomeViewModel model) {
    //     model.loadData();
    //   },
    //   builder: (BuildContext context, HomeViewModel model, Widget widget) {
    //     print("builder:===><");
    //     return Scaffold(
    //         backgroundColor: Colors.white,
    //         appBar: AppBar(
    //           title: Text('首页'),
    //         ),
    //         body: Builder(
    //             builder: (context) => Center(
    //                 child: model.viewState == ViewState.loading
    //                     ? CircularProgressIndicator()
    //                     : Column(
    //                         children: <Widget>[
    //                           // Text('APP首页 ${widget.arguments['mobile']} '),
    //                           Text('APP首页 ${model?.count} '),
    //                           FlatButton(
    //                             onPressed: () {
    //                               model.fav();
    //                             },
    //                             child: Text('点击'),
    //                           ),
    //                         ],
    //                       ))));
    //   },
    // );
  }
}
