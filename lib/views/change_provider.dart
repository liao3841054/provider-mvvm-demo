import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestModel with ChangeNotifier {
  int modelValue;

  int get value => modelValue;

  TestModel({this.modelValue = 0});

  void add() {
    modelValue++;
    notifyListeners();
  }
}

class ChangeProviderOfView extends StatefulWidget {
  final Map arguments;
  const ChangeProviderOfView({Key key, this.arguments}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<ChangeProviderOfView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("ChangeProviderOfView build===");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('ChangeProviderOfView'),
        ),
        body: Center(
          child: ChangeNotifierProvider(
            create: (_) => TestModel(modelValue: 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ChildWidget1(),
                  SizedBox(height: 24),
                  ChildWidget2(),
                ],
              ),
            ),
          ),
        ));
  }
}

var style = TextStyle(color: Colors.white);

class ChildWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('ChildWidget1 build');
    var model = Provider.of<TestModel>(context);
    return Container(
      color: Colors.redAccent,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Child1', style: style),
          Text('Model data: ${model.value}', style: style),
          RaisedButton(
            onPressed: () => model.add(),
            child: Text('add'),
          ),
        ],
      ),
    );
  }
}

class ChildWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('ChildWidget2 build');
    var model = Provider.of<TestModel>(context);
    return Container(
      color: Colors.blueAccent,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Child2', style: style),
          Text('Model data: ${model.value}', style: style),
          RaisedButton(
            onPressed: () => model.add(),
            child: Text('add'),
          ),
        ],
      ),
    );
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
