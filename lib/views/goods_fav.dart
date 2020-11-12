import 'package:flutter/material.dart';
import 'package:flutter_provider_mvvm/viewmodels/goods_fav_viemodel.dart';
import 'package:provider/provider.dart';

class GoodsListScreen extends StatelessWidget {
  /// 异步延迟加载，如果使用组件中Context，当前组件已经dispose了，导致没法获取provider异常
  BuildContext _localContext;

  @override
  Widget build(BuildContext context) {
    print('GoodsListScreen- build');
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return GoodsListProvider();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('GoodsListScreen'),
          actions: [
            Consumer<GoodsListProvider>(
              builder: (context, GoodsListProvider model, child) {
                return FlatButton(
                  onPressed: () {
                    GoodsListProvider provider =
                        context.read()<GoodsListProvider>();
                    provider.clear();
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
        body: Selector<GoodsListProvider, GoodsListProvider>(
          selector: (BuildContext context, GoodsListProvider provider) {
            _localContext = context;
            return provider;
          },
          shouldRebuild: (pre, next) => pre.shouldRebuild,
          builder:
              (BuildContext context, GoodsListProvider provider, Widget child) {
            provider.rebuild();

            return NotificationListener(
              onNotification: (ScrollNotification notification) {
                _scrollNotification(context, notification);
                return true;
              },
              child: ListView.builder(
                  itemCount: provider.total + 1,
                  itemBuilder: (context, index) {
                    if (index == provider.total) {
                      return Selector<GoodsListProvider, PageStatus>(
                        selector: (_, GoodsListProvider provider) {
                          return provider.status;
                        },
                        builder: (BuildContext context, PageStatus value,
                            Widget child) {
                          print('=====>${getPageStatusText(value)}');

                          if (value == PageStatus.loadingMore) {
                            Future.delayed(
                                Duration(
                                  milliseconds: 2000,
                                ), () {
                              GoodsListProvider provider =
                                  Provider.of(_localContext, listen: false);
                              provider.addAll();
                              if (provider.total > 100) {
                                provider
                                    .changePageStatus(PageStatus.loadMoreOver);
                              }
                            });
                          }

                          return FlatButton(
                            onPressed: () {
                              GoodsListProvider provider =
                                  context.read<GoodsListProvider>();
                              provider.addAll();
                            },
                            child: Text(
                              getPageStatusText(value),
                              style: TextStyle(color: Colors.redAccent),
                            ),
                          );
                        },
                      );
                    }
                    return Selector<GoodsListProvider, Goods>(
                      selector:
                          (BuildContext context, GoodsListProvider provider) {
                        return provider.goodList[index];
                      },
                      shouldRebuild: (Goods pre, Goods next) {
                        return pre.isCollection != next.isCollection;
                      },
                      builder:
                          (BuildContext context, Goods good, Widget child) {
                        return MyListTile(
                          title: Text(good.goodName + '====> $index'),
                          trailing: GestureDetector(
                            onTap: () => provider.collect(index),
                            child: Icon(good.isCollection
                                ? Icons.star
                                : Icons.star_border),
                          ),
                        );
                      },
                    );
                  }),
            );
          },
        ),
        floatingActionButton: Selector<GoodsListProvider, bool>(
          selector: (BuildContext context, GoodsListProvider provider) {
            return provider.showBackTopButton;
          },
          shouldRebuild: (pre, next) {
            return pre != next;
          },
          builder: (BuildContext context, bool value, Widget child) {
            return Visibility(
              visible: value,
              child: FlatButton(
                color: Colors.lightBlue,
                child: Text('返回顶部'),
                onPressed: () {},
              ),
            );
          },
        ),
      ),
    );
  }

  _scrollNotification(BuildContext context, ScrollNotification notification) {
    GoodsListProvider provider = Provider.of(context, listen: false);
    if (notification.metrics.pixels > 1000) {
      provider.showBackUp(true);
    } else {
      provider.showBackUp(false);
    }

    ///显示加载更多..
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        provider.status != PageStatus.loadMoreOver) {
      provider.changePageStatus(PageStatus.loadingMore);
    }
  }
}

/// 打印ListTile 是否进行了build
class MyListTile extends ListTile {
  MyListTile({Text title, Widget trailing})
      : super(
          title: title,
          trailing: trailing,
        );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('MyListTile===> build ${title}');

    return Column(
      children: <Widget>[
        super.build(context),
        Divider(),
      ],
    );
  }
}
