import 'route_mixin.dart';

class RouteUtils with RouteMixin {
  static final RouteUtils instance = RouteUtils._();

  factory RouteUtils() => instance;

  RouteUtils._();
}
