import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'base_view_model.dart';

class BaseViewModelWidget<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;

  final T model;
  final Widget child;
  final Function(T) onModelReady;

  const BaseViewModelWidget(
      {Key key, this.builder, this.model, this.onModelReady, this.child})
      : super(key: key);

  @override
  _BaseViewModelWidgetState<T> createState() => _BaseViewModelWidgetState<T>();
}

class _BaseViewModelWidgetState<T extends BaseViewModel>
    extends State<BaseViewModelWidget<T>> {
  T _model;

  @override
  void initState() {
    // TODO: implement initState
    _model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady(_model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (BuildContext context) {
        return _model;
      },
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
