import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'route_manager.dart';

mixin RouteMixin {
  GoRouter get _router {
    return RouteManager.routeConfig;
  }

  GlobalKey<NavigatorState> get navigatorKey => RouteManager.navigatorKey;

  BuildContext? get navContext => RouteManager.navigatorKey.currentContext;

  List<GoRoute> get routeStack => RouteManager.routeStack;

  List<String> get pathStack => RouteManager.pathStack;

  String get currentPath => RouteManager.currentRoutePath;

  void addListener(VoidCallback listener) {
    RouteManager.delegate.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    RouteManager.delegate.removeListener(listener);
  }

  void go(String location, {Object? extra}) =>
      _router.go(location, extra: extra);

  void goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      _router.goNamed(name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          extra: extra);

  Future<T?> push<T extends Object?>(String location, {Object? extra}) =>
      _router.push(location, extra: extra);

  Future<T?> pushNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      _router.pushNamed(name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          extra: extra);

  Future<T?> pushReplacement<T extends Object?>(String location,
          {Object? extra}) =>
      _router.pushReplacement(location, extra: extra);

  Future<T?> pushReplacementNamed<T extends Object?>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      _router.pushReplacementNamed(name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          extra: extra);

  Future<T?> replace<T>(String location, {Object? extra}) =>
      _router.replace(location, extra: extra);

  Future<T?> replaceNamed<T>(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      _router.replaceNamed(name,
          pathParameters: pathParameters, queryParameters: queryParameters);

  Future<T?> pushOrReplace<T>(String location, {Object? extra}) {
    if (currentPath == location) {
      return _router.replace(location, extra: extra);
    } else {
      return _router.push(location, extra: extra);
    }
  }

  void pop<T extends Object?>([T? result]) => _router.pop(result);

  Future<T?> showAppGeneralDialog<T extends Object?>({
    required RoutePageBuilder pageBuilder,
    bool barrierDismissible = false,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) return Future.value(null);
    return showGeneralDialog(
      context: context,
      pageBuilder: pageBuilder,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      barrierColor: barrierColor,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
  }

  Future<T?> showAppModalBottomSheet<T>({
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null || !context.mounted) return Future.value(null);
    return showModalBottomSheet(
      context: context,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
    );
  }
}
