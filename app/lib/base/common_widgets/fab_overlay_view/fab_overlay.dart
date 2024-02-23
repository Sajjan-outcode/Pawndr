import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../buttons/image_button.dart';
import 'fab_action_item.dart';

class FABOverlayView extends StatefulWidget {
  final double right;
  final double bottom;
  final List<FABActionItem> items;
  final Function? onClosed;
  const FABOverlayView(
      {required this.right,
      required this.bottom,
      required this.items,
      this.onClosed,
      super.key});

  @override
  State<FABOverlayView> createState() => FABOverlayViewState();
}

class FABOverlayViewState extends State<FABOverlayView> {
  bool _isActionsShowing = false;

  List<FABActionItem> _items = [];

  @override
  void initState() {
    _items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _getStackItems(),
    );
  }

  closeFABOverlay() {
    _isActionsShowing = false;
    setState(() {});
    widget.onClosed?.call();
  }

  List<Widget> _actionItemsViews() {
    List<Widget> actionItemsViews = [];
    int offset = 60;
    for (FABActionItem item in _items) {
      actionItemsViews.add(
        AnimatedPositioned(
          bottom: _isActionsShowing ? widget.bottom + offset : widget.bottom,
          right: widget.right,
          duration: const Duration(milliseconds: 200),
          child: Visibility(visible: item.isVisible, child: item.widget),
          onEnd: () {
            item.isVisible = _isActionsShowing;
            setState(() {});
          },
        ),
      );
      offset += 60;
    }
    return actionItemsViews;
  }

  List<Widget> _getStackItems() {
    List<Widget> stackItems = [];
    stackItems.add(
      Visibility(
        visible: _isActionsShowing,
        child: GestureDetector(
          onTap: () {
            _onBackgroundTapped();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.black.withOpacity(0.7),
          ),
        ),
      ),
    );
    stackItems.addAll(_actionItemsViews());
    stackItems.add(Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: widget.bottom, right: widget.right),
        child: ImageButton(
          angle: _isActionsShowing ? -0.12 : 0,
          cornerRadius: 16,
          icon: Icons.add,
          hasShadow: false,
          onClick: () {
            _makeItemsVisible();
            _isActionsShowing = !_isActionsShowing;
            setState(() {});
            widget.onClosed?.call();
          },
        ),
      ),
    ));
    return stackItems;
  }

  _onBackgroundTapped() {
    closeFABOverlay();
  }

  _makeItemsVisible() {
    for (FABActionItem item in _items) {
      item.isVisible = true;
    }
  }
}
