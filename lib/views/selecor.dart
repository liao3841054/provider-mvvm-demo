import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestModel with ChangeNotifier {
  int modelValueA;
  int modelValueB;

  int get valueA => modelValueA;

  int get valueB => modelValueB;

  TestModel({this.modelValueA = 0, this.modelValueB = 0});

  void addA() {
    modelValueA++;
    notifyListeners();
  }

  void addB() {
    modelValueB++;
    notifyListeners();
  }
}

class SelectorView extends StatefulWidget {
  final Map arguments;

  const SelectorView({Key key, this.arguments}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<SelectorView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("SelectorView build===");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('SelectorView'),
        ),
        body: ProviderState3Widget());
  }
}

class ProviderState3Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TestModel(modelValueA: 1, modelValueB: 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ChildWidgetA(),
            SizedBox(height: 24),
            ChildWidgetB(),
            SizedBox(height: 24),
            Selector<TestModel, int>(
              selector: (context, value) => value.modelValueA,
              builder: (BuildContext context, value, Widget child) {
                print(
                    "hlwang ------------------ > selector ChildC value : ${value} !");
                return ChildWidgetWithValue(
                  label: "ChildC",
                  color: Colors.green,
                );
              },
            ),
            SizedBox(height: 24),
            Selector<TestModel, int>(
              selector: (context, value) => value.modelValueA,
              builder: (BuildContext context, value, Widget child) {
                print(
                    "hlwang ------------------ > selector ChildD value : ${value} !");
                return ChildWidgetWithValue(
                  label: "ChildD",
                  color: Colors.deepPurple,
                );
              },
              shouldRebuild: (int previous, int next) => true, // 总是返回true，与ChildC 相比，这里是差异点
            ),
            SizedBox(height: 24),
            Selector<TestModel, int>(
              selector: (context, value) => value.modelValueB,
              builder: (BuildContext context, value, Widget child) {
                print(
                    "hlwang ------------------ > selector ChildE value : ${value} !");
                return ChildWidgetWithValue(
                  label: "ChildE",
                  color: Colors.amber,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

var style = TextStyle(color: Colors.white);

class ChildWidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('ChildWidgetA build');
    var model = Provider.of<TestModel>(context,listen: false);
    return Container(
      color: Colors.redAccent,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('ChildA', style: style),
          Text('Model data: ${model.valueB}', style: style),
          RaisedButton(
            onPressed: () => model.addA(),
            child: Text('add'),
          ),
        ],
      ),
    );
  }
}

class ChildWidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('ChildWidgetB build');
    var model = Provider.of<TestModel>(context,listen: false);
    return Container(
      color: Colors.blueAccent,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('ChildB', style: style),
          Text('Model data: ${model.valueB}', style: style),
          RaisedButton(
            onPressed: () => model.addB(),
            child: Text('add'),
          ),
        ],
      ),
    );
  }
}

class ChildWidgetWithValue extends StatelessWidget {
  final String label;
  final Color color;

  ChildWidgetWithValue({this.label, this.color});

  @override
  Widget build(BuildContext context) {
    debugPrint('Widget ${label} build');
    var model = Provider.of<TestModel>(context,listen: false);
    return Container(
      color: color ?? Colors.blueAccent,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(label, style: style),
          Text('Model data: ${model.valueB}', style: style),
          RaisedButton(
            onPressed: () => model.addB(),
            child: Text('add'),
          ),
        ],
      ),
    );
  }
}
