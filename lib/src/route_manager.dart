import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import 'base_route.dart';
import 'route_register.dart';

@internal
class RouteManager extends RouteRegister {
  static final RouteManager _instance = RouteManager._();

  factory RouteManager() => _instance;

  RouteManager._();

  late GoRouter _goRouter;

  static GoRouter get routeConfig => _instance._goRouter;

  static GlobalKey<NavigatorState> get navigatorKey =>
      routeConfig.configuration.navigatorKey;

  final Map<String, BaseRoute> _routes = {};

  ///当前路由栈中页面
  static List<GoRoute> get routeStack =>
      routeConfig.routerDelegate.currentConfiguration.routes
          .map((e) => e as GoRoute)
          .toList();

  static GoRouterDelegate get delegate => routeConfig.routerDelegate;

  ///当前路由栈中页面的path
  static List<String> get pathStack => routeStack.map((e) => e.path).toList();

  ///当前栈顶路由
  static String get currentRoutePath {
    final pathList = pathStack;
    return pathList.isNotEmpty ? pathList.last : '';
  }

  @override
  void register(BaseRoute route) {
    assert(!_routes.containsKey(route.path), "当前路由已经被注册");
    _routes[route.path] = route;
  }

  static List<GoRoute> get getAllRoutes {
    return _instance._routes.values.map((e) => e.createRoute()).toList();
  }

  void _createRoute({
    String? initialLocation,
    Object? initialExtra,
    List<NavigatorObserver>? observers,
    bool debugLogDiagnostics = false,
    GlobalKey<NavigatorState>? navigatorKey,
    GoRouterRedirect? redirect,
  }) {
    _goRouter = GoRouter(
        routes: getAllRoutes,
        initialLocation: initialLocation,
        initialExtra: initialExtra,
        observers: observers,
        debugLogDiagnostics: debugLogDiagnostics,
        navigatorKey: navigatorKey,
        redirect: redirect);
  }

  ///这个方法必须提前调用，否则会出错
  static void initRoute({
    String? initialLocation,
    Object? initialExtra,
    List<NavigatorObserver>? observers,
    bool debugLogDiagnostics = false,
    GlobalKey<NavigatorState>? navigatorKey,
    GoRouterRedirect? redirect,
  }) {
    _instance._createRoute(
        initialLocation: initialLocation,
        initialExtra: initialExtra,
        observers: observers,
        debugLogDiagnostics: debugLogDiagnostics,
        navigatorKey: navigatorKey,
        redirect: redirect);
  }
}
