import 'notification_event.dart';

enum NotificationDestination {
  home,
  orderDetail,
  wallet,
  unknown,
}

class NotificationRouteResult {
  const NotificationRouteResult({
    required this.destination,
    this.entityId,
  });

  final NotificationDestination destination;
  final String? entityId;
}

class NotificationRouter {
  NotificationRouteResult resolve(NotificationEvent event) {
    switch (event.route) {
      case '/':
      case '/home':
        return const NotificationRouteResult(
          destination: NotificationDestination.home,
        );
      case '/orders/detail':
        return NotificationRouteResult(
          destination: NotificationDestination.orderDetail,
          entityId: event.entityId,
        );
      case '/wallet':
        return const NotificationRouteResult(
          destination: NotificationDestination.wallet,
        );
      default:
        return const NotificationRouteResult(
          destination: NotificationDestination.unknown,
        );
    }
  }
}
