import 'package:appboy/providers/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CustomAppBarScroller extends StatefulWidget {
  static const String id = 'scroller-screen';
  @override
  _CustomAppBarScrollerState createState() => _CustomAppBarScrollerState();
}

class _CustomAppBarScrollerState extends State<CustomAppBarScroller>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// Controller to scroll or jump to a particular item.
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  AutoScrollController _autoScrollController;
  final scrollDirection = Axis.vertical;

  bool isExpanded = true;

  TabController _tabController;

  //here we want to add or remove items to the map based on the visibility of the items
  //so that we can calculate the current index of tab bar on the visibility of the current item
  final Map<int, bool> _visibleItems = {0: true};

  bool _isAppBarExpanded(BuildContext context) {
    if (!_autoScrollController.hasClients) return false;
    print(
        "The offset scrolled now is ${_autoScrollController.offset} and the height is now ${(MediaQuery.of(context).size.height / 1.6 - kToolbarHeight)}");

    return _autoScrollController.offset >
        (MediaQuery.of(context).size.height / 1.6 - kToolbarHeight);
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 1,
      vsync: this,
    );
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    )..addListener(() {
        if (_isAppBarExpanded(context)) {
          if (isExpanded) {
            setState(
              () {
                isExpanded = false;
                print('setState is called');
              },
            );
          }
        } else if (!isExpanded) {
          setState(() {
            print('setState is called');
            isExpanded = true;
          });
        }
      });

    super.initState();
  }

  Future _scrollToIndex(int index) async {
    print(
        "The offset scrolled now is before updating ${_autoScrollController.offset} and the height is now ${(MediaQuery.of(context).size.height / 1.6 - kToolbarHeight)}");

    print("The index to scroll to item is this $index");
    await _autoScrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    await _autoScrollController.highlight(index,
        animated: true, highlightDuration: Duration(seconds: 2));
    // itemScrollController.jumpTo(index: index, alignment: 1.00);
  }

  Widget _wrapScrollTag({int index, Widget child}) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index,
      child: child,
      highlightColor: Colors.black.withOpacity(0.1),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _store = Provider.of<StoreProvider>(context);
    return CustomScrollView(controller: _autoScrollController, slivers: [
      SliverAppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        pinned: true,
        snap: false,
        expandedHeight: size.height / 1.33,
        leading: !isExpanded
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            : Container(),
        actions: [
          !isExpanded
              ? IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 32,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // _showSearchSection(context);
                  },
                )
              : Container(),
        ],
        title: !isExpanded
            ? Text(
                _store.storedetails['address'] ?? "",
                style: TextStyle(color: Colors.black),
              )
            : Container(),
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          // title: !isExpanded ? Text("Detail View",style: TextStyle(color: blackColor),) : Container(),
          //background: _buildSliverAppbarBackground(context),
        ),
      ),
    ]);
  }

  @override
  // implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
