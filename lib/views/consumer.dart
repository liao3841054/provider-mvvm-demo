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

class ConsumerView extends StatefulWidget {
  final Map arguments;
  const ConsumerView({Key key, this.arguments}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<ConsumerView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var style = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    print("InheritedView build===");
    return Scaffold(
      appBar: AppBar(
        title: Text('ConsumerView'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => TestModel(modelValue: 1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.redAccent,
              height: 48,
              child: Consumer<TestModel>(
                builder: (BuildContext context, value, Widget child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Child1', style: style),
                      Text('Model data: ${value.value}', style: style),
                      RaisedButton(
                        onPressed: () =>
                            Provider.of<TestModel>(context, listen: false)
                                .add(),
                        child: Text('add'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
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
