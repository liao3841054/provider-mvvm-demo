import 'package:flutter/cupertino.dart';

enum PageStatus {
  notStart,
  loading,
  loadingMore,
  loadMoreOver,
  loadMoreError,
}

String getPageStatusText(PageStatus status) {
  switch (status) {
    case PageStatus.notStart:
      return '未开始';
      break;
    case PageStatus.loading:
      return '加载中...';
      break;
    case PageStatus.loadingMore:
      return '加载更多...';
      break;
    case PageStatus.loadMoreError:
      return '加载更多异常';
      break;
    case PageStatus.loadMoreOver:
      return '加载更多完成';
      break;
  }
  return '未知';
}

class GoodsListProvider with ChangeNotifier {
  bool shouldRebuild = false;

  bool _showBackTopButton = false;

  PageStatus _status = PageStatus.notStart;

  List<Goods> _goodList =
      List.generate(10, (index) => Goods(false, 'Goods No. $index'));

  /// 商品数据立碑
  get goodList => _goodList;

  /// 返回顶部
  get showBackTopButton => _showBackTopButton;

  /// 页面加载状态
  get status => _status;

  Goods good(index) => _goodList[index];

  get total => _goodList.length;

  collect(index) {
    var good = _goodList[index];
    _goodList[index] = Goods(!good.isCollection, good.goodName);
    notifyListeners();
  }

  addAll() {
    _goodList.addAll(
        List.generate(10, (index) => Goods(false, '--Goods No. $index')));
    shouldRebuild = true;
    notifyListeners();
  }

  clear() {
    _goodList.clear();
    shouldRebuild = true;
    _status = PageStatus.notStart;
    notifyListeners();
  }

  rebuild() {
    shouldRebuild = false;
  }

  showBackUp(bool up) {
    _showBackTopButton = up;
    notifyListeners();
  }

  changePageStatus(PageStatus status) {
    _status = status;
    notifyListeners();
  }
}

class Goods {
  final bool isCollection;
  final String goodName;

  Goods(this.isCollection, this.goodName);
}
