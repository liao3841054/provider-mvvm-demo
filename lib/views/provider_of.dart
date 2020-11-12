import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderOfView extends StatefulWidget {
  final Map arguments;
  const ProviderOfView({Key key, this.arguments}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<ProviderOfView> {
  int _count = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("InheritedView build===");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('InheritedView'),
        ),
        body: Center(
          child: Provider.value(
            value: _count,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _TestWidget(), //子widget中依赖ShareDataWidget
                ),
                RaisedButton(
                  child: Text("Increment"),
                  //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
                  onPressed: () => setState(() => ++_count),
                )
              ],
            ),
          ),
        ));
  }
}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => new __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text('${Provider.of<int>(context)}');
//    return Text('${Provider.of<int>(context, listen: false)}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}
