import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    print("InheritedView build===");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('InheritedView'),
        ),
        body: Column(
          children: <Widget>[
            // Text('APP首页 ${widget.arguments['mobile']} '),
            FlatButton(
              onPressed: () {},
              child: Text('点击'),
            ),
          ],
        ));
  }
}
