import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

abstract class BaseRoute extends GoRouteData {
  ///路由路径
  String get path;

  String? get name => runtimeType.toString();

  List<GoRoute> get subRoutes => [];

  GlobalKey<NavigatorState>? get parentNavigatorKey => null;

  @internal
  GoRoute createRoute() {
    return GoRoute(
      path: path,
      name: name,
      builder: build,
      pageBuilder: buildPage,
      redirect: redirect,
      routes: subRoutes,
      parentNavigatorKey: parentNavigatorKey,
    );
  }
}
