import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class ButtonStyleData {
  const ButtonStyleData({
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.foregroundDecoration,
    this.elevation,
    this.overlayColor,
  });

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final BoxDecoration? foregroundDecoration;
  final int? elevation;

  final MaterialStateProperty<Color?>? overlayColor;
}

class IconStyleData {
  const IconStyleData({
    this.icon = const Icon(Icons.arrow_drop_down),
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24,
    this.openMenuIcon,
  });

  final Widget icon;
  final Color? iconDisabledColor;

  final Color? iconEnabledColor;
  final double iconSize;

  final Widget? openMenuIcon;
}

class DropdownStyleData {
  const DropdownStyleData({
    this.maxHeight,
    this.width,
    this.padding,
    this.scrollPadding,
    this.decoration,
    this.elevation = 8,
    this.direction = DropdownDirection.textDirection,
    this.offset = Offset.zero,
    this.isOverButton = false,
    this.useSafeArea = true,
    @Deprecated('Use useRootNavigator instead.') this.isFullScreen,
    this.useRootNavigator = false,
    this.scrollbarTheme,
    this.openInterval = const Interval(0.25, 0.5),
    this.dropdownBuilder,
  });

  final double? maxHeight;

  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? scrollPadding;
  final BoxDecoration? decoration;
  final int elevation;
  final DropdownDirection direction;
  final Offset offset;

  final bool isOverButton;

  final bool useSafeArea;
  @Deprecated('Use useRootNavigator instead.')
  final bool? isFullScreen;

  final bool useRootNavigator;
  final ScrollbarThemeData? scrollbarTheme;

  final Interval openInterval;

  final DropdownBuilder? dropdownBuilder;
}

class MenuItemStyleData {
  const MenuItemStyleData({
    this.padding,
    this.borderRadius,
    this.overlayColor,
    this.selectedMenuItemBuilder,
  });
  final EdgeInsetsGeometry? padding;

  final BorderRadius? borderRadius;

  final MaterialStateProperty<Color?>? overlayColor;

  final SelectedMenuItemBuilder? selectedMenuItemBuilder;
}

class DropdownSearchData<T> {
  const DropdownSearchData({
    this.searchController,
    this.searchBarWidget,
    this.searchBarWidgetHeight,
    this.noResultsWidget,
    this.searchMatchFn,
  }) : assert(
          (searchBarWidget == null) == (searchBarWidgetHeight == null),
          'searchBarWidgetHeight should not be null when using searchBarWidget\n'
          'This is necessary to properly determine menu limits and scroll offset',
        );
  final TextEditingController? searchController;
  final Widget? searchBarWidget;

  final double? searchBarWidgetHeight;
  final Widget? noResultsWidget;

  final SearchMatchFn<T>? searchMatchFn;
}

class _DropdownRoute<T> extends PopupRoute<_DropdownRouteResult<T>> {
  _DropdownRoute({
    required this.items,
    required this.buttonRect,
    required this.selectedIndex,
    required this.isNoSelectedItem,
    required this.onChanged,
    required this.capturedThemes,
    required this.style,
    required this.barrierDismissible,
    Color? barrierColor,
    this.barrierLabel,
    required this.barrierCoversButton,
    required this.parentFocusNode,
    required this.enableFeedback,
    required this.dropdownStyle,
    required this.menuItemStyle,
    required this.searchData,
    this.dropdownSeparator,
  })  : itemHeights = addSeparatorsHeights(
          itemHeights: items.map((item) => item.height).toList(),
          separatorHeight: dropdownSeparator?.height,
        ),
        barrierColor = barrierCoversButton ? barrierColor : null,
        _altBarrierColor = barrierColor;

  final List<DropdownItem<T>> items;
  final ValueNotifier<Rect?> buttonRect;
  final int selectedIndex;
  final bool isNoSelectedItem;
  final ValueChanged<T?>? onChanged;
  final CapturedThemes capturedThemes;
  final TextStyle style;
  final FocusNode parentFocusNode;
  final bool enableFeedback;
  final DropdownStyleData dropdownStyle;
  final MenuItemStyleData menuItemStyle;
  final DropdownSearchData<T>? searchData;
  final DropdownSeparator<T>? dropdownSeparator;

  final List<double> itemHeights;
  ScrollController? scrollController;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;
  final Color? _altBarrierColor;

  @override
  final String? barrierLabel;

  final bool barrierCoversButton;

  final FocusScopeNode _childNode = FocusScopeNode(debugLabel: 'Child');

  @override
  Widget buildPage(BuildContext context, _, __) {
    return FocusScope.withExternalFocusNode(
      focusScopeNode: _childNode,
      parentNode: parentFocusNode,
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          final padding = MediaQuery.paddingOf(context);
          final viewInsets = MediaQuery.viewInsetsOf(context);
          final BoxConstraints actualConstraints = constraints.copyWith(
              maxHeight: constraints.maxHeight - viewInsets.bottom);
          final EdgeInsets mediaQueryPadding =
              dropdownStyle.useSafeArea ? padding : EdgeInsets.zero;
          return ValueListenableBuilder<Rect?>(
            valueListenable: buttonRect,
            builder: (BuildContext context, Rect? rect, _) {
              final routePage = _DropdownRoutePage<T>(
                route: this,
                constraints: actualConstraints,
                mediaQueryPadding: mediaQueryPadding,
                buttonRect: rect!,
                selectedIndex: selectedIndex,
                capturedThemes: capturedThemes,
                style: style,
                enableFeedback: enableFeedback,
              );
              return barrierCoversButton
                  ? routePage
                  : _CustomModalBarrier(
                      animation: animation,
                      barrierColor: _altBarrierColor,
                      barrierCurve: barrierCurve,
                      buttonRect: rect,
                      child: routePage,
                    );
            },
          );
        },
      ),
    );
  }

  void _dismiss() {
    if (isActive) {
      _childNode.dispose();
      navigator?.removeRoute(this);
    }
  }

  double getItemOffset(int index) {
    final double paddingTop = dropdownStyle.padding != null
        ? dropdownStyle.padding!.resolve(null).top
        : kMaterialListPadding.top;
    double offset = paddingTop;

    if (items.isNotEmpty && index > 0) {
      assert(
        items.length + (dropdownSeparator != null ? items.length - 1 : 0) ==
            itemHeights.length,
      );
      offset += itemHeights
          .sublist(0, index)
          .reduce((double total, double height) => total + height);
    }

    return offset;
  }

  _MenuLimits getMenuLimits(
    Rect buttonRect,
    double availableHeight,
    EdgeInsets mediaQueryPadding,
    int index,
  ) {
    double maxHeight =
        getMenuAvailableHeight(availableHeight, mediaQueryPadding);
    final double? preferredMaxHeight = dropdownStyle.maxHeight;
    if (preferredMaxHeight != null) {
      maxHeight = math.min(maxHeight, preferredMaxHeight);
    }

    double actualMenuHeight =
        dropdownStyle.padding?.vertical ?? kMaterialListPadding.vertical;
    final double innerWidgetHeight = searchData?.searchBarWidgetHeight ?? 0.0;
    actualMenuHeight += innerWidgetHeight;
    if (items.isNotEmpty) {
      actualMenuHeight +=
          itemHeights.reduce((double total, double height) => total + height);
    }

    final double menuHeight = math.min(maxHeight, actualMenuHeight);

    double menuTop = dropdownStyle.isOverButton
        ? buttonRect.top - dropdownStyle.offset.dy
        : buttonRect.bottom - dropdownStyle.offset.dy;
    double menuBottom = menuTop + menuHeight;

    final double topLimit = mediaQueryPadding.top;
    final double bottomLimit = availableHeight - mediaQueryPadding.bottom;
    if (menuTop < topLimit) {
      menuTop = topLimit;
      menuBottom = menuTop + menuHeight;
    } else if (menuBottom > bottomLimit) {
      menuBottom = bottomLimit;
      menuTop = menuBottom - menuHeight;
    }

    double scrollOffset = 0;
    if (actualMenuHeight > maxHeight) {
      final double menuNetHeight = menuHeight - innerWidgetHeight;
      final double actualMenuNetHeight = actualMenuHeight - innerWidgetHeight;
      final actualIndex = dropdownSeparator?.height != null ? index * 2 : index;
      final double selectedItemOffset = getItemOffset(actualIndex);
      scrollOffset = math.max(
          0.0,
          selectedItemOffset -
              (menuNetHeight / 2) +
              (itemHeights[actualIndex] / 2));
      final double maxScrollOffset = actualMenuNetHeight - menuNetHeight;
      scrollOffset = math.min(scrollOffset, maxScrollOffset);
    }

    assert((menuBottom - menuTop - menuHeight).abs() < precisionErrorTolerance);
    return _MenuLimits(menuTop, menuBottom, menuHeight, scrollOffset);
  }

  double getMenuAvailableHeight(
    double availableHeight,
    EdgeInsets mediaQueryPadding,
  ) {
    return math.max(
      0.0,
      availableHeight - mediaQueryPadding.vertical - _kMenuItemHeight,
    );
  }
}

class _DropdownRoutePage<T> extends StatelessWidget {
  const _DropdownRoutePage({
    super.key,
    required this.route,
    required this.constraints,
    required this.mediaQueryPadding,
    required this.buttonRect,
    required this.selectedIndex,
    this.elevation = 8,
    required this.capturedThemes,
    this.style,
    required this.enableFeedback,
  });

  final _DropdownRoute<T> route;
  final BoxConstraints constraints;
  final EdgeInsets mediaQueryPadding;
  final Rect buttonRect;
  final int selectedIndex;
  final int elevation;
  final CapturedThemes capturedThemes;
  final TextStyle? style;
  final bool enableFeedback;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    if (route.scrollController == null) {
      final _MenuLimits menuLimits = route.getMenuLimits(
        buttonRect,
        constraints.maxHeight,
        mediaQueryPadding,
        selectedIndex,
      );
      route.scrollController =
          ScrollController(initialScrollOffset: menuLimits.scrollOffset);
    }

    final TextDirection? textDirection = Directionality.maybeOf(context);

    final Widget menu = _DropdownMenu<T>(
      route: route,
      textDirection: textDirection,
      buttonRect: buttonRect,
      constraints: constraints,
      mediaQueryPadding: mediaQueryPadding,
      enableFeedback: enableFeedback,
    );

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _DropdownMenuRouteLayout<T>(
              route: route,
              textDirection: textDirection,
              buttonRect: buttonRect,
              availableHeight: constraints.maxHeight,
              mediaQueryPadding: mediaQueryPadding,
            ),
            child: capturedThemes.wrap(menu),
          );
        },
      ),
    );
  }
}

class _DropdownMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _DropdownMenuRouteLayout({
    required this.route,
    required this.buttonRect,
    required this.availableHeight,
    required this.mediaQueryPadding,
    required this.textDirection,
  });

  final _DropdownRoute<T> route;
  final Rect buttonRect;
  final double availableHeight;
  final EdgeInsets mediaQueryPadding;
  final TextDirection? textDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final double? itemWidth = route.dropdownStyle.width;
    double maxHeight =
        route.getMenuAvailableHeight(availableHeight, mediaQueryPadding);
    final double? preferredMaxHeight = route.dropdownStyle.maxHeight;
    if (preferredMaxHeight != null && preferredMaxHeight <= maxHeight) {
      maxHeight = preferredMaxHeight;
    }
    final double width =
        math.min(constraints.maxWidth, itemWidth ?? buttonRect.width);
    return BoxConstraints(
      minWidth: width,
      maxWidth: width,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final _MenuLimits menuLimits = route.getMenuLimits(
      buttonRect,
      availableHeight,
      mediaQueryPadding,
      route.selectedIndex,
    );

    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect) == buttonRect) {
        assert(menuLimits.top >= 0.0);
        assert(menuLimits.top + menuLimits.height <= size.height);
      }
      return true;
    }());
    assert(textDirection != null);

    final Offset offset = route.dropdownStyle.offset;
    final double left;

    switch (route.dropdownStyle.direction) {
      case DropdownDirection.textDirection:
        switch (textDirection!) {
          case TextDirection.rtl:
            left = clampDouble(
              buttonRect.right - childSize.width + offset.dx,
              0.0,
              size.width - childSize.width,
            );
            break;
          case TextDirection.ltr:
            left = clampDouble(
              buttonRect.left + offset.dx,
              0.0,
              size.width - childSize.width,
            );
            break;
        }
        break;
      case DropdownDirection.right:
        left = clampDouble(
          buttonRect.left + offset.dx,
          0.0,
          size.width - childSize.width,
        );
        break;
      case DropdownDirection.left:
        left = clampDouble(
          buttonRect.right - childSize.width + offset.dx,
          0.0,
          size.width - childSize.width,
        );
        break;
      case DropdownDirection.center:
        left = clampDouble(
          (size.width - childSize.width) / 2 + offset.dx,
          0.0,
          size.width - childSize.width,
        );
        break;
    }

    return Offset(left, menuLimits.top);
  }

  @override
  bool shouldRelayout(_DropdownMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect ||
        textDirection != oldDelegate.textDirection;
  }
}

@immutable
class _DropdownRouteResult<T> {
  const _DropdownRouteResult(this.result);

  final T? result;

  @override
  bool operator ==(Object other) {
    return other is _DropdownRouteResult<T> && other.result == result;
  }

  @override
  int get hashCode => result.hashCode;
}

class _CustomModalBarrier extends StatefulWidget {
  const _CustomModalBarrier({
    this.animation,
    this.barrierColor,
    required this.barrierCurve,
    required this.child,
    this.buttonRect,
  });

  final Animation<double>? animation;
  final Color? barrierColor;
  final Curve barrierCurve;
  final Widget child;
  final Rect? buttonRect;

  @override
  State<_CustomModalBarrier> createState() => _CustomModalBarrierState();
}

class _CustomModalBarrierState extends State<_CustomModalBarrier> {
  late final Animation<Color?> color;

  @override
  void initState() {
    super.initState();
    color = widget.animation!.drive(
      ColorTween(
        begin: widget.barrierColor?.withOpacity(0.0),
        end: widget.barrierColor,
      ).chain(CurveTween(curve: widget.barrierCurve)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: color,
          builder: (BuildContext context, Color? value, Widget? child) {
            return CustomPaint(
              painter: _DropdownBarrierPainter(
                buttonRect: widget.buttonRect,
                barrierColor: value,
                pageSize: size,
              ),
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class _DropdownBarrierPainter extends CustomPainter {
  const _DropdownBarrierPainter({
    this.buttonRect,
    this.barrierColor,
    required this.pageSize,
  });

  final Rect? buttonRect;
  final Color? barrierColor;
  final Size pageSize;

  @override
  void paint(Canvas canvas, Size size) {
    if (barrierColor != null && buttonRect != null) {
      final Rect rect = Rect.fromLTRB(
          -buttonRect!.left, -buttonRect!.top, pageSize.width, pageSize.height);
      canvas.saveLayer(rect, Paint());
      canvas.drawRect(rect, Paint()..color = barrierColor!);
      canvas.drawRect(buttonRect!, Paint()..blendMode = BlendMode.clear);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_DropdownBarrierPainter oldPainter) {
    return oldPainter.buttonRect != buttonRect ||
        oldPainter.barrierColor != barrierColor;
  }
}

SearchMatchFn<T> _defaultSearchMatchFn<T>() =>
    (DropdownItem<T> item, String searchValue) =>
        item.value.toString().toLowerCase().contains(searchValue.toLowerCase());

class _MenuLimits {
  const _MenuLimits(this.top, this.bottom, this.height, this.scrollOffset);

  final double top;
  final double bottom;
  final double height;
  final double scrollOffset;
}

class _DropdownMenu<T> extends StatefulWidget {
  const _DropdownMenu({
    super.key,
    required this.route,
    required this.textDirection,
    required this.buttonRect,
    required this.constraints,
    required this.mediaQueryPadding,
    required this.enableFeedback,
  });

  final _DropdownRoute<T> route;
  final TextDirection? textDirection;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final EdgeInsets mediaQueryPadding;
  final bool enableFeedback;

  @override
  _DropdownMenuState<T> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
  late CurvedAnimation _fadeOpacity;
  late CurvedAnimation _resize;
  late List<Widget> _children;
  late SearchMatchFn<T> _searchMatchFn;

  List<DropdownItem<T>> get items => widget.route.items;

  DropdownStyleData get dropdownStyle => widget.route.dropdownStyle;

  DropdownSearchData<T>? get searchData => widget.route.searchData;

  _DropdownItemButton<T> dropdownItemButton(int index) =>
      _DropdownItemButton<T>(
        route: widget.route,
        textDirection: widget.textDirection,
        buttonRect: widget.buttonRect,
        constraints: widget.constraints,
        mediaQueryPadding: widget.mediaQueryPadding,
        itemIndex: index,
        enableFeedback: widget.enableFeedback,
      );

  @override
  void initState() {
    super.initState();
    _fadeOpacity = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
    _resize = CurvedAnimation(
      parent: widget.route.animation!,
      curve: dropdownStyle.openInterval,
      reverseCurve: const Threshold(0.0),
    );
    final searchController = searchData?.searchController;
    if (searchController == null) {
      _children = <Widget>[
        for (int index = 0; index < items.length; ++index)
          dropdownItemButton(index),
      ];
    } else {
      _searchMatchFn = searchData?.searchMatchFn ?? _defaultSearchMatchFn();
      _children = _getSearchItems();
      searchController.addListener(_onSearchChange);
    }
  }

  void _onSearchChange() {
    _children = _getSearchItems();
    setState(() {});
  }

  List<Widget> _getSearchItems() {
    final String currentSearch = searchData!.searchController!.text;
    return <Widget>[
      for (int index = 0; index < items.length; ++index)
        if (_searchMatchFn(items[index], currentSearch))
          dropdownItemButton(index),
    ];
  }

  @override
  void dispose() {
    _fadeOpacity.dispose();
    _resize.dispose();
    searchData?.searchController?.removeListener(_onSearchChange);
    super.dispose();
  }

  final _states = <MaterialState>{
    MaterialState.dragged,
    MaterialState.hovered,
  };

  bool get _isIOS => Theme.of(context).platform == TargetPlatform.iOS;

  ScrollbarThemeData? get _scrollbarTheme => dropdownStyle.scrollbarTheme;

  bool get _iOSThumbVisibility =>
      _scrollbarTheme?.thumbVisibility?.resolve(_states) ?? true;

  bool get _hasIntrinsicHeight =>
      widget.route.items.any((item) => item.intrinsicHeight) ||
      (widget.route.dropdownSeparator != null &&
          widget.route.dropdownSeparator!.intrinsicHeight);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final _DropdownRoute<T> route = widget.route;

    final separator = widget.route.dropdownSeparator;

    final Widget dropdownMenu = Material(
      type: MaterialType.transparency,
      textStyle: route.style,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (searchData?.searchBarWidget != null) searchData!.searchBarWidget!,
          if (_children.isEmpty && searchData?.noResultsWidget != null)
            searchData!.noResultsWidget!
          else
            Flexible(
              child: Padding(
                padding: dropdownStyle.scrollPadding ?? EdgeInsets.zero,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                    overscroll: false,
                    physics: const ClampingScrollPhysics(),
                    platform: Theme.of(context).platform,
                  ),
                  child: PrimaryScrollController(
                    controller: route.scrollController!,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        scrollbarTheme: dropdownStyle.scrollbarTheme,
                      ),
                      child: Scrollbar(
                        thumbVisibility:
                            _isIOS ? _iOSThumbVisibility : true,
                        thickness: _isIOS
                            ? _scrollbarTheme?.thickness?.resolve(_states)
                            : null,
                        radius: _isIOS ? _scrollbarTheme?.radius : null,
                        child: ListView.custom(
                          primary: true,
                          shrinkWrap: true,
                          padding:
                              dropdownStyle.padding ?? kMaterialListPadding,
                          itemExtentBuilder: _hasIntrinsicHeight
                              ? null
                              : (index, dimensions) {
                                  final childrenLength = separator == null
                                      ? _children.length
                                      : SeparatedSliverChildBuilderDelegate
                                          .computeActualChildCount(
                                              _children.length);
                                  if (index >= childrenLength) {
                                    return 100;
                                  }
                                  return separator != null && index.isOdd
                                      ? separator.height
                                      : route.itemHeights[index];
                                },
                          childrenDelegate: separator == null
                              ? SliverChildBuilderDelegate(
                                  (context, index) => _children[index],
                                  childCount: _children.length,
                                )
                              : SeparatedSliverChildBuilderDelegate(
                                  itemCount: _children.length,
                                  itemBuilder: (context, index) =>
                                      _children[index],
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: separator.intrinsicHeight
                                        ? null
                                        : separator.height,
                                    child: separator,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    return FadeTransition(
      opacity: _fadeOpacity,
      child: CustomPaint(
        painter: _DropdownMenuPainter(
          color: Theme.of(context).canvasColor,
          elevation: dropdownStyle.elevation,
          selectedIndex: route.selectedIndex,
          resize: _resize,
          itemHeight: items[0].height,
          dropdownDecoration: dropdownStyle.decoration,
        ),
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: localizations.popupMenuLabel,
          child: ClipRRect(
            clipBehavior: dropdownStyle.decoration?.borderRadius != null
                ? Clip.antiAlias
                : Clip.none,
            borderRadius: dropdownStyle.decoration?.borderRadius
                    ?.resolve(Directionality.of(context)) ??
                BorderRadius.zero,
            child: dropdownStyle.dropdownBuilder?.call(context, dropdownMenu) ??
                dropdownMenu,
          ),
        ),
      ),
    );
  }
}

class _DropdownMenuPainter extends CustomPainter {
  _DropdownMenuPainter({
    this.color,
    this.elevation,
    this.selectedIndex,
    required this.resize,
    required this.itemHeight,
    this.dropdownDecoration,
  })  : _painter = dropdownDecoration
                ?.copyWith(
                  color: dropdownDecoration.color ?? color,
                  boxShadow: dropdownDecoration.boxShadow ??
                      kElevationToShadow[elevation],
                )
                .createBoxPainter(() {}) ??
            BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(2.0)),
              boxShadow: kElevationToShadow[elevation],
            ).createBoxPainter(),
        super(repaint: resize);

  final Color? color;
  final int? elevation;
  final int? selectedIndex;
  final Animation<double> resize;
  final double itemHeight;
  final BoxDecoration? dropdownDecoration;

  final BoxPainter _painter;

  @override
  void paint(Canvas canvas, Size size) {
    final Tween<double> top = Tween<double>(
      begin: 0.0,
      end: 0.0,
    );

    final Tween<double> bottom = Tween<double>(
      begin: clampDouble(top.begin! + itemHeight,
          math.min(itemHeight, size.height), size.height),
      end: size.height,
    );

    final Rect rect = Rect.fromLTRB(
        0.0, top.evaluate(resize), size.width, bottom.evaluate(resize));

    _painter.paint(canvas, rect.topLeft, ImageConfiguration(size: rect.size));
  }

  @override
  bool shouldRepaint(_DropdownMenuPainter oldPainter) {
    return oldPainter.color != color ||
        oldPainter.elevation != elevation ||
        oldPainter.selectedIndex != selectedIndex ||
        oldPainter.dropdownDecoration != dropdownDecoration ||
        oldPainter.itemHeight != itemHeight ||
        oldPainter.resize != resize;
  }
}

class DropdownItem<T> extends _DropdownMenuItemContainer {
  const DropdownItem({
    required super.child,
    super.height,
    super.intrinsicHeight,
    super.alignment,
    this.onTap,
    this.value,
    this.enabled = true,
    this.closeOnTap = true,
    super.key,
  });

  final VoidCallback? onTap;
  final T? value;
  final bool enabled;
  final bool closeOnTap;
  DropdownItem<T> copyWith({
    Widget? child,
    double? height,
    bool? intrinsicHeight,
    void Function()? onTap,
    T? value,
    bool? enabled,
    AlignmentGeometry? alignment,
    bool? closeOnTap,
  }) {
    return DropdownItem<T>(
      height: height ?? this.height,
      intrinsicHeight: intrinsicHeight ?? this.intrinsicHeight,
      onTap: onTap ?? this.onTap,
      value: value ?? this.value,
      enabled: enabled ?? this.enabled,
      alignment: alignment ?? this.alignment,
      closeOnTap: closeOnTap ?? this.closeOnTap,
      child: child ?? this.child,
    );
  }
}

class _DropdownMenuItemContainer extends StatelessWidget {
  const _DropdownMenuItemContainer({
    super.key,
    this.alignment = AlignmentDirectional.centerStart,
    required this.child,
    this.height = _kMenuItemHeight,
    this.intrinsicHeight = false,
  });
  final Widget child;
  final AlignmentGeometry alignment;
  final double height;
  final bool intrinsicHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: intrinsicHeight ? null : height,
      alignment: alignment,
      child: child,
    );
  }
}
class _DropdownItemButton<T> extends StatefulWidget {
  const _DropdownItemButton({
    super.key,
    required this.route,
    required this.textDirection,
    required this.buttonRect,
    required this.constraints,
    required this.mediaQueryPadding,
    required this.itemIndex,
    required this.enableFeedback,
  });

  final _DropdownRoute<T> route;
  final TextDirection? textDirection;
  final Rect buttonRect;
  final BoxConstraints constraints;
  final EdgeInsets mediaQueryPadding;
  final int itemIndex;
  final bool enableFeedback;

  @override
  _DropdownItemButtonState<T> createState() => _DropdownItemButtonState<T>();
}

class _DropdownItemButtonState<T> extends State<_DropdownItemButton<T>> {
  void _handleFocusChange(bool focused) {
    final bool inTraditionalMode;
    switch (FocusManager.instance.highlightMode) {
      case FocusHighlightMode.touch:
        inTraditionalMode = false;
        break;
      case FocusHighlightMode.traditional:
        inTraditionalMode = true;
        break;
    }

    if (focused && inTraditionalMode) {
      final _MenuLimits menuLimits = widget.route.getMenuLimits(
        widget.buttonRect,
        widget.constraints.maxHeight,
        widget.mediaQueryPadding,
        widget.itemIndex,
      );
      widget.route.scrollController!.animateTo(
        menuLimits.scrollOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 100),
      );
    }
  }

  void _handleOnTap() {
    final DropdownItem<T> dropdownItem = widget.route.items[widget.itemIndex];

    dropdownItem.onTap?.call();
    widget.route.onChanged?.call(dropdownItem.value);

    if (dropdownItem.closeOnTap) {
      Navigator.pop(
        context,
        _DropdownRouteResult<T>(dropdownItem.value),
      );
    }
  }

  static const Map<ShortcutActivator, Intent> _webShortcuts =
      <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowDown):
        DirectionalFocusIntent(TraversalDirection.down),
    SingleActivator(LogicalKeyboardKey.arrowUp):
        DirectionalFocusIntent(TraversalDirection.up),
  };

  MenuItemStyleData get menuItemStyle => widget.route.menuItemStyle;

  @override
  Widget build(BuildContext context) {
    final double menuCurveEnd = widget.route.dropdownStyle.openInterval.end;

    final DropdownItem<T> dropdownItem = widget.route.items[widget.itemIndex];
    final double unit = 0.5 / (widget.route.items.length + 1.5);
    final double start =
        clampDouble(menuCurveEnd + (widget.itemIndex + 1) * unit, 0.0, 1.0);
    final double end = clampDouble(start + 1.5 * unit, 0.0, 1.0);
    final CurvedAnimation opacity = CurvedAnimation(
        parent: widget.route.animation!, curve: Interval(start, end));

    Widget child = Container(
      padding: (menuItemStyle.padding ?? _kMenuItemPadding)
          .resolve(widget.textDirection),
      child: dropdownItem,
    );
    if (dropdownItem.enabled) {
      final bool isSelectedItem = !widget.route.isNoSelectedItem &&
          widget.itemIndex == widget.route.selectedIndex;
      child = InkWell(
        autofocus: isSelectedItem,
        enableFeedback: widget.enableFeedback,
        onTap: _handleOnTap,
        onFocusChange: _handleFocusChange,
        borderRadius: menuItemStyle.borderRadius,
        overlayColor: menuItemStyle.overlayColor,
        child: isSelectedItem
            ? menuItemStyle.selectedMenuItemBuilder?.call(context, child) ??
                child
            : child,
      );
    }
    child = FadeTransition(opacity: opacity, child: child);
    if (kIsWeb && dropdownItem.enabled) {
      child = Shortcuts(
        shortcuts: _webShortcuts,
        child: child,
      );
    }
    return child;
  }
}

class DropdownSeparator<T> extends DropdownItem<T> {
  const DropdownSeparator({
    required super.child,
    super.height,
    super.enabled = false,
    super.key,
  });
}

class SeparatedSliverChildBuilderDelegate extends SliverChildBuilderDelegate {
  SeparatedSliverChildBuilderDelegate({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    required IndexedWidgetBuilder separatorBuilder,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    ChildIndexGetter? findChildIndexCallback,
  }) : super(
          (BuildContext context, int index) {
            final itemIndex = index ~/ 2;

            if (index.isEven) {
              return itemBuilder(context, itemIndex);
            }

            final widget = separatorBuilder(context, itemIndex);

            return widget;
          },
          findChildIndexCallback: findChildIndexCallback,
          childCount: computeActualChildCount(itemCount),
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          addRepaintBoundaries: addRepaintBoundaries,
          addSemanticIndexes: addSemanticIndexes,
          semanticIndexCallback: (Widget _, int index) {
            return index.isEven ? index ~/ 2 : null;
          },
        );
  static int computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}

enum DropdownDirection {
  textDirection,
  right,
  left,
  center,
}

List<double> addSeparatorsHeights({
  required List<double> itemHeights,
  required double? separatorHeight,
}) {
  final List<double> heights = [];

  bool addSeparator = false;
  if (separatorHeight != null) {
    for (final item in itemHeights) {
      if (addSeparator) {
        heights.add(separatorHeight);
      }
      heights.add(item);
      addSeparator = true;
    }
  } else {
    heights.addAll(itemHeights);
  }

  return heights;
}

void _uniqueValueAssert<T>(
  List<DropdownItem<T>>? items,
  ValueListenable<T?>? valueListenable,
  ValueListenable<List<T>>? multiValueListenable,
) {
  if (items == null || items.isEmpty) {
    return;
  }

  String assertMessage(T value) {
    return "There should be exactly one item with [DropdownButton]'s value: "
        '$value. \n'
        'Either zero or 2 or more [DropdownItem]s were detected '
        'with the same value';
  }

  assert(
    valueListenable?.value == null ||
        items.where((DropdownItem<T> item) {
              return item.value == valueListenable!.value;
            }).length ==
            1,
    assertMessage(valueListenable!.value as T),
  );

  final currentMultiValue = multiValueListenable?.value.lastOrNull;
  assert(
    currentMultiValue == null ||
        items.where((DropdownItem<T> item) {
              return item.value == currentMultiValue;
            }).length ==
            1,
    assertMessage(currentMultiValue),
  );
}

const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);
const double _kMenuItemHeight = kMinInteractiveDimension;
const double _kDenseButtonHeight = 24.0;
const EdgeInsets _kMenuItemPadding = EdgeInsets.symmetric(horizontal: 16.0);
const EdgeInsetsGeometry _kAlignedButtonPadding =
    EdgeInsetsDirectional.only(start: 16.0, end: 4.0);
const EdgeInsets _kUnalignedButtonPadding = EdgeInsets.zero;

typedef SelectedMenuItemBuilder = Widget Function(
    BuildContext context, Widget child);

typedef DropdownBuilder = Widget Function(BuildContext context, Widget child);

typedef OnMenuStateChangeFn = void Function(bool isOpen);

typedef SearchMatchFn<T> = bool Function(
    DropdownItem<T> item, String searchValue);

class DropdownButton2<T> extends StatefulWidget {
  const DropdownButton2({
    super.key,
    required this.items,
    this.selectedItemBuilder,
    this.valueListenable,
    this.multiValueListenable,
    this.hint,
    this.disabledHint,
    this.onChanged,
    this.onMenuStateChange,
    this.style,
    this.underline,
    this.isDense = false,
    this.isExpanded = false,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.buttonStyleData,
    this.iconStyleData = const IconStyleData(),
    this.dropdownStyleData = const DropdownStyleData(),
    this.menuItemStyleData = const MenuItemStyleData(),
    this.dropdownSearchData,
    this.dropdownSeparator,
    this.customButton,
    this.openWithLongPress = false,
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    this.barrierCoversButton = true,
    this.openDropdownListenable,
  })  : assert(
          valueListenable == null || multiValueListenable == null,
          'Only one of valueListenable or multiValueListenable can be used.',
        ),
        _inputDecoration = null,
        _isEmpty = false,
        _isFocused = false;

  const DropdownButton2._formField({
    super.key,
    required this.items,
    this.selectedItemBuilder,
    required this.valueListenable,
    required this.multiValueListenable,
    this.hint,
    this.disabledHint,
    required this.onChanged,
    this.onMenuStateChange,
    this.style,
    this.underline,
    this.isDense = false,
    this.isExpanded = false,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.buttonStyleData,
    required this.iconStyleData,
    required this.dropdownStyleData,
    required this.menuItemStyleData,
    this.dropdownSearchData,
    this.dropdownSeparator,
    this.customButton,
    this.openWithLongPress = false,
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierCoversButton = true,
    this.barrierLabel,
    this.openDropdownListenable,
    required InputDecoration inputDecoration,
    required bool isEmpty,
    required bool isFocused,
  })  : _inputDecoration = inputDecoration,
        _isEmpty = isEmpty,
        _isFocused = isFocused;

  final List<DropdownItem<T>>? items;

  final DropdownButtonBuilder? selectedItemBuilder;

  final ValueListenable<T?>? valueListenable;

  final ValueListenable<List<T>>? multiValueListenable;

  final Widget? hint;
  final Widget? disabledHint;
  final ValueChanged<T?>? onChanged;

  final OnMenuStateChangeFn? onMenuStateChange;

  final TextStyle? style;
  final Widget? underline;
  final bool isDense;
  final bool isExpanded;

  final FocusNode? focusNode;

  final bool autofocus;
  final bool? enableFeedback;
  final AlignmentGeometry alignment;

  final ButtonStyleData? buttonStyleData;

  final IconStyleData iconStyleData;

  final DropdownStyleData dropdownStyleData;

  final MenuItemStyleData menuItemStyleData;

  final DropdownSearchData<T>? dropdownSearchData;

  final DropdownSeparator<T>? dropdownSeparator;

  final Widget? customButton;

  final bool openWithLongPress;

  final bool barrierDismissible;

  final Color? barrierColor;

  final String? barrierLabel;

  final bool barrierCoversButton;

  final Listenable? openDropdownListenable;

  final InputDecoration? _inputDecoration;

  final bool _isEmpty;

  final bool _isFocused;

  @override
  State<DropdownButton2<T>> createState() => _DropdownButton2State<T>();
}

class _DropdownButton2State<T> extends State<DropdownButton2<T>>
    with WidgetsBindingObserver {
  int? _selectedIndex;
  _DropdownRoute<T>? _dropdownRoute;
  Orientation? _lastOrientation;
  FocusNode? _internalNode;

  ButtonStyleData? get _buttonStyle => widget.buttonStyleData;

  IconStyleData get _iconStyle => widget.iconStyleData;

  DropdownStyleData get _dropdownStyle => widget.dropdownStyleData;

  MenuItemStyleData get _menuItemStyle => widget.menuItemStyleData;

  DropdownSearchData<T>? get _searchData => widget.dropdownSearchData;

  FocusNode get _focusNode => widget.focusNode ?? _internalNode!;

  late Map<Type, Action<Intent>> _actionMap;

  final ValueNotifier<bool> _isMenuOpen = ValueNotifier<bool>(false);

  final ValueNotifier<Rect?> _rect = ValueNotifier<Rect?>(null);

  FocusNode _createFocusNode() {
    return FocusNode(debugLabel: '${widget.runtimeType}');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateSelectedIndex();
    widget.valueListenable?.addListener(_updateSelectedIndex);
    widget.multiValueListenable?.addListener(_updateSelectedIndex);
    widget.openDropdownListenable?.addListener(_programmaticallyOpenDropdown);
    if (widget.focusNode == null) {
      _internalNode ??= _createFocusNode();
    }
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (ActivateIntent intent) => _handleTap(),
      ),
      ButtonActivateIntent: CallbackAction<ButtonActivateIntent>(
        onInvoke: (ButtonActivateIntent intent) => _handleTap(),
      ),
    };
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.valueListenable?.removeListener(_updateSelectedIndex);
    widget.multiValueListenable?.removeListener(_updateSelectedIndex);
    widget.openDropdownListenable
        ?.removeListener(_programmaticallyOpenDropdown);
    _removeDropdownRoute();
    _internalNode?.dispose();
    _isMenuOpen.dispose();
    _rect.dispose();
    super.dispose();
  }

  T? get _currentValue {
    if (widget.valueListenable != null) {
      return widget.valueListenable!.value;
    }
    if (widget.multiValueListenable != null) {
      return widget.multiValueListenable!.value.lastOrNull;
    }
    return null;
  }

  void _removeDropdownRoute() {
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
    _lastOrientation = null;
  }

  @override
  void didUpdateWidget(DropdownButton2<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode == null) {
      _internalNode ??= _createFocusNode();
    }
    if (widget.valueListenable != oldWidget.valueListenable ||
        widget.multiValueListenable != oldWidget.multiValueListenable) {
      _updateSelectedIndex();
      oldWidget.valueListenable?.removeListener(_updateSelectedIndex);
      oldWidget.multiValueListenable?.removeListener(_updateSelectedIndex);
      widget.valueListenable?.addListener(_updateSelectedIndex);
      widget.multiValueListenable?.addListener(_updateSelectedIndex);
    }
    if (widget.openDropdownListenable != oldWidget.openDropdownListenable) {
      oldWidget.openDropdownListenable
          ?.removeListener(_programmaticallyOpenDropdown);
      widget.openDropdownListenable?.addListener(_programmaticallyOpenDropdown);
    }
  }

  void _updateSelectedIndex() {
    if (widget.items == null ||
        widget.items!.isEmpty ||
        (_currentValue == null &&
            widget.items!
                .where((DropdownItem<T> item) =>
                    item.enabled && item.value == _currentValue)
                .isEmpty)) {
      _selectedIndex = null;
      return;
    }

    assert(widget.items!
            .where((DropdownItem<T> item) => item.value == _currentValue)
            .length ==
        1);
    for (int itemIndex = 0; itemIndex < widget.items!.length; itemIndex++) {
      if (widget.items![itemIndex].value == _currentValue) {
        _selectedIndex = itemIndex;
        return;
      }
    }
  }

  void _programmaticallyOpenDropdown() {
    if (_enabled && !_isMenuOpen.value) {
      _handleTap();
    }
  }

  @override
  void didChangeMetrics() {
    //This fix the bug of calling didChangeMetrics() on iOS when app starts
    if (_rect.value == null) {
      return;
    }
    final Rect newRect = _getRect();
    //This avoid unnecessary rebuilds if _rect position hasn't changed
    if (_rect.value!.top == newRect.top) {
      return;
    }
    _rect.value = newRect;
  }

  TextStyle? get _textStyle =>
      widget.style ?? Theme.of(context).textTheme.titleMedium;

  Rect _getRect() {
    final TextDirection? textDirection = Directionality.maybeOf(context);
    const EdgeInsetsGeometry menuMargin = EdgeInsets.zero;
    final NavigatorState navigator = Navigator.of(context,
        rootNavigator:
            _dropdownStyle.isFullScreen ?? _dropdownStyle.useRootNavigator);

    final RenderBox itemBox = context.findRenderObject()! as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(Offset.zero,
            ancestor: navigator.context.findRenderObject()) &
        itemBox.size;

    return menuMargin.resolve(textDirection).inflateRect(itemRect);
  }

  EdgeInsetsGeometry _getMenuPadding() {
    return (_menuItemStyle.padding ?? _kMenuItemPadding)
        .add(_dropdownStyle.padding ?? EdgeInsets.zero)
        .add(_dropdownStyle.scrollPadding ?? EdgeInsets.zero);
  }

  void _handleTap() {
    final NavigatorState navigator = Navigator.of(context,
        rootNavigator:
            _dropdownStyle.isFullScreen ?? _dropdownStyle.useRootNavigator);

    final items = widget.items!;
    final separator = widget.dropdownSeparator;
    _rect.value = _getRect();

    assert(_dropdownRoute == null);
    _dropdownRoute = _DropdownRoute<T>(
      items: items,
      buttonRect: _rect,
      selectedIndex: _selectedIndex ?? 0,
      isNoSelectedItem: _selectedIndex == null,
      onChanged: widget.onChanged,
      capturedThemes:
          InheritedTheme.capture(from: context, to: navigator.context),
      style: _textStyle!,
      barrierDismissible: widget.barrierDismissible,
      barrierColor: widget.barrierColor,
      barrierLabel: widget.barrierLabel ??
          MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierCoversButton: widget.barrierCoversButton,
      parentFocusNode: _focusNode,
      enableFeedback: widget.enableFeedback ?? true,
      dropdownStyle: _dropdownStyle,
      menuItemStyle: _menuItemStyle,
      searchData: _searchData,
      dropdownSeparator: separator,
    );

    _isMenuOpen.value = true;
    _focusNode.requestFocus();
    // This is a temporary fix for the "dropdown menu steal the focus from the
    // underlying button" issue, until share focus is fixed in flutter (#106923).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dropdownRoute?._childNode.requestFocus();
    });
    navigator
        .push(_dropdownRoute!)
        .then<void>((_DropdownRouteResult<T>? newValue) {
      _removeDropdownRoute();
      _isMenuOpen.value = false;
      widget.onMenuStateChange?.call(false);
    });

    widget.onMenuStateChange?.call(true);
  }

  double get _denseButtonHeight {
    // ignore: deprecated_member_use
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);
    final double fontSize = _textStyle!.fontSize ??
        Theme.of(context).textTheme.titleMedium!.fontSize!;
    final double scaledFontSize = textScaleFactor * fontSize;
    return math.max(
        scaledFontSize, math.max(_iconStyle.iconSize, _kDenseButtonHeight));
  }

  Color get _iconColor {
    // These colors are not defined in the Material Design spec.
    if (_enabled) {
      if (_iconStyle.iconEnabledColor != null) {
        return _iconStyle.iconEnabledColor!;
      }

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade700;
        case Brightness.dark:
          return Colors.white70;
      }
    } else {
      if (_iconStyle.iconDisabledColor != null) {
        return _iconStyle.iconDisabledColor!;
      }

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade400;
        case Brightness.dark:
          return Colors.white10;
      }
    }
  }

  bool get _enabled =>
      widget.items != null &&
      widget.items!.isNotEmpty &&
      widget.onChanged != null;

  Orientation _getOrientation(BuildContext context) {
    Orientation? result = MediaQuery.maybeOrientationOf(context);
    if (result == null) {
      // If there's no MediaQuery, then use the current FlutterView to determine
      // orientation.
      final Size size = View.of(context).physicalSize;
      result = size.width > size.height
          ? Orientation.landscape
          : Orientation.portrait;
    }
    return result;
  }

  BorderRadius? _getButtonBorderRadius(BuildContext context) {
    final buttonRadius = _buttonStyle?.decoration?.borderRadius ??
        _buttonStyle?.foregroundDecoration?.borderRadius;
    if (buttonRadius != null) {
      return buttonRadius.resolve(Directionality.of(context));
    }

    final inputBorder = widget._inputDecoration?.border;
    if (inputBorder?.isOutline ?? false) {
      return (inputBorder! as OutlineInputBorder).borderRadius;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));

    final Orientation newOrientation = _getOrientation(context);
    _lastOrientation ??= newOrientation;
    if (newOrientation != _lastOrientation) {
      _removeDropdownRoute();
      _lastOrientation = newOrientation;
    }

    final List<Widget> buttonItems = widget.selectedItemBuilder == null
        ? (widget.items != null ? List<Widget>.of(widget.items!) : <Widget>[])
        : List<Widget>.of(widget.selectedItemBuilder!(context));

    int? hintIndex;
    if (widget.hint != null || (!_enabled && widget.disabledHint != null)) {
      final Widget displayedHint =
          _enabled ? widget.hint! : widget.disabledHint ?? widget.hint!;

      hintIndex = buttonItems.length;
      buttonItems.add(DefaultTextStyle(
        style: _textStyle!.copyWith(color: Theme.of(context).hintColor),
        child: IgnorePointer(
          child: displayedHint,
        ),
      ));
    }

    final EdgeInsetsGeometry padding = ButtonTheme.of(context).alignedDropdown
        ? _kAlignedButtonPadding
        : _kUnalignedButtonPadding;

    final buttonHeight =
        _buttonStyle?.height ?? (widget.isDense ? _denseButtonHeight : null);

    final Widget innerItemsWidget = buttonItems.isEmpty
        ? const SizedBox.shrink()
        : ValueListenableBuilder(
            valueListenable: widget.valueListenable ??
                widget.multiValueListenable ??
                ValueNotifier(null),
            builder: (context, multiValue, _) {
              _uniqueValueAssert(
                widget.items,
                widget.valueListenable,
                widget.multiValueListenable,
              );
              Widget item = buttonItems[_selectedIndex ?? hintIndex ?? 0];
              if (item is DropdownItem) {
                item = item.copyWith(alignment: widget.alignment);
              }

              return buttonHeight != null && _buttonStyle?.width != null
                  ? Align(
                      alignment: widget.alignment,
                      child: item,
                    )
                  : IndexedStack(
                      index: _selectedIndex ?? hintIndex,
                      alignment: widget.alignment,
                      children: buttonHeight != null
                          ? buttonItems
                          : buttonItems.map((item) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[item],
                              );
                            }).toList(),
                    );
            },
          );

    Widget result = DefaultTextStyle(
      style: _enabled
          ? _textStyle!
          : _textStyle!.copyWith(color: Theme.of(context).disabledColor),
      child: widget.customButton ??
          Container(
            decoration: _buttonStyle?.decoration?.copyWith(
              boxShadow: _buttonStyle!.decoration!.boxShadow ??
                  kElevationToShadow[_buttonStyle!.elevation ?? 0],
            ),
            foregroundDecoration: _buttonStyle?.foregroundDecoration?.copyWith(
              boxShadow: _buttonStyle!.foregroundDecoration!.boxShadow ??
                  kElevationToShadow[_buttonStyle!.elevation ?? 0],
            ),
            padding: (_buttonStyle?.padding ??
                    padding.resolve(Directionality.of(context)))
                .add(
              _buttonStyle?.width == null && _dropdownStyle.width == null
                  ? _getMenuPadding()
                      .resolve(Directionality.of(context))
                      .copyWith(top: 0, bottom: 0)
                  : EdgeInsets.zero,
            ),
            height: buttonHeight,
            width: _buttonStyle?.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.isExpanded)
                  Expanded(child: innerItemsWidget)
                else
                  innerItemsWidget,
                IconTheme(
                  data: IconThemeData(
                    color: _iconColor,
                    size: _iconStyle.iconSize,
                  ),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _isMenuOpen,
                    builder: (BuildContext context, bool isOpen, _) {
                      return _iconStyle.openMenuIcon != null
                          ? isOpen
                              ? _iconStyle.openMenuIcon!
                              : _iconStyle.icon
                          : _iconStyle.icon;
                    },
                  ),
                ),
              ],
            ),
          ),
    );

    if (!DropdownButtonHideUnderline.at(context)) {
      final double bottom = widget.isDense ? 0.0 : 8.0;
      result = Stack(
        children: <Widget>[
          result,
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: bottom,
            child: widget.underline ??
                Container(
                  height: 1.0,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFBDBDBD),
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
          ),
        ],
      );
    }

    final MouseCursor effectiveMouseCursor =
        MaterialStateProperty.resolveAs<MouseCursor>(
      MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!_enabled) MaterialState.disabled,
      },
    );

    if (widget._inputDecoration != null) {
      result = InputDecorator(
        decoration: widget._inputDecoration!,
        isEmpty: widget._isEmpty,
        isFocused: widget._isFocused,
        child: result,
      );
    }

    return Semantics(
      button: true,
      child: Actions(
        actions: _actionMap,
        child: InkWell(
          mouseCursor: effectiveMouseCursor,
          onTap: _enabled && !widget.openWithLongPress ? _handleTap : null,
          onLongPress: _enabled && widget.openWithLongPress ? _handleTap : null,
          canRequestFocus: _enabled,
          focusNode: _focusNode,
          autofocus: widget.autofocus,
          overlayColor: _buttonStyle?.overlayColor,
          enableFeedback: false,
          borderRadius: _getButtonBorderRadius(context),
          child: result,
        ),
      ),
    );
  }
}

class DropdownButtonFormField2<T> extends FormField<T> {
  DropdownButtonFormField2({
    super.key,
    required List<DropdownItem<T>>? items,
    DropdownButtonBuilder? selectedItemBuilder,
    ValueListenable<T?>? valueListenable,
    ValueListenable<List<T>>? multiValueListenable,
    Widget? hint,
    Widget? disabledHint,
    this.onChanged,
    OnMenuStateChangeFn? onMenuStateChange,
    TextStyle? style,
    bool isDense = true,
    bool isExpanded = false,
    FocusNode? focusNode,
    bool autofocus = false,
    InputDecoration? decoration,
    super.onSaved,
    super.validator,
    AutovalidateMode? autovalidateMode,
    bool? enableFeedback,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
    ButtonStyleData? buttonStyleData,
    IconStyleData iconStyleData = const IconStyleData(),
    DropdownStyleData dropdownStyleData = const DropdownStyleData(),
    MenuItemStyleData menuItemStyleData = const MenuItemStyleData(),
    DropdownSearchData<T>? dropdownSearchData,
    DropdownSeparator<T>? dropdownSeparator,
    Widget? customButton,
    bool openWithLongPress = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    Listenable? openDropdownListenable,
  })  : assert(
          valueListenable == null || multiValueListenable == null,
          'Only one of valueListenable or multiValueListenable can be used.',
        ),
        decoration = _getInputDecoration(decoration, buttonStyleData),
        super(
          initialValue: valueListenable != null
              ? valueListenable.value
              : multiValueListenable?.value.lastOrNull,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<T> field) {
            final _DropdownButtonFormFieldState<T> state =
                field as _DropdownButtonFormFieldState<T>;
            final InputDecoration decorationArg =
                _getInputDecoration(decoration, buttonStyleData);
            final InputDecoration effectiveDecoration =
                decorationArg.applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );

            final bool showSelectedItem = items != null &&
                items
                    .where((DropdownItem<T> item) => item.value == state.value)
                    .isNotEmpty;
            bool isHintOrDisabledHintAvailable() {
              final bool isDropdownDisabled =
                  onChanged == null || (items == null || items.isEmpty);
              if (isDropdownDisabled) {
                return hint != null || disabledHint != null;
              } else {
                return hint != null;
              }
            }

            final bool isEmpty =
                !showSelectedItem && !isHintOrDisabledHintAvailable();

            return Focus(
              canRequestFocus: false,
              skipTraversal: true,
              child: Builder(
                builder: (BuildContext context) {
                  return InputDecorator(
                    decoration: const InputDecoration.collapsed(hintText: '')
                        .copyWith(errorText: field.errorText),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<T>._formField(
                        items: items,
                        selectedItemBuilder: selectedItemBuilder,
                        valueListenable: valueListenable,
                        multiValueListenable: multiValueListenable,
                        hint: hint,
                        disabledHint: disabledHint,
                        onChanged: onChanged == null ? null : state.didChange,
                        onMenuStateChange: onMenuStateChange,
                        style: style,
                        isDense: isDense,
                        isExpanded: isExpanded,
                        focusNode: focusNode,
                        autofocus: autofocus,
                        enableFeedback: enableFeedback,
                        alignment: alignment,
                        buttonStyleData: buttonStyleData,
                        iconStyleData: iconStyleData,
                        dropdownStyleData: dropdownStyleData,
                        menuItemStyleData: menuItemStyleData,
                        dropdownSearchData: dropdownSearchData,
                        dropdownSeparator: dropdownSeparator,
                        customButton: customButton,
                        openWithLongPress: openWithLongPress,
                        barrierDismissible: barrierDismissible,
                        barrierColor: barrierColor,
                        barrierLabel: barrierLabel,
                        openDropdownListenable: openDropdownListenable,
                        inputDecoration: effectiveDecoration,
                        isEmpty: isEmpty,
                        isFocused: Focus.of(context).hasFocus,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );

  final ValueChanged<T?>? onChanged;
  final InputDecoration decoration;

  static InputDecoration _getInputDecoration(
      InputDecoration? decoration, ButtonStyleData? buttonStyleData) {
    return decoration ??
        InputDecoration(
          focusColor: buttonStyleData?.overlayColor
              ?.resolve(<MaterialState>{MaterialState.focused}),
          hoverColor: buttonStyleData?.overlayColor
              ?.resolve(<MaterialState>{MaterialState.hovered}),
        );
  }

  @override
  FormFieldState<T> createState() => _DropdownButtonFormFieldState<T>();
}

class _DropdownButtonFormFieldState<T> extends FormFieldState<T> {
  @override
  void didChange(T? value) {
    super.didChange(value);
    final DropdownButtonFormField2<T> dropdownButtonFormField =
        widget as DropdownButtonFormField2<T>;
    assert(dropdownButtonFormField.onChanged != null);
    dropdownButtonFormField.onChanged!(value);
  }

  @override
  void didUpdateWidget(DropdownButtonFormField2<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setValue(widget.initialValue);
    }
  }
}
