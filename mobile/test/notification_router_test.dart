import 'package:flutter_test/flutter_test.dart';
import 'package:realtime_notification_demo/notification_event.dart';
import 'package:realtime_notification_demo/notification_router.dart';

void main() {
  final router = NotificationRouter();

  test('routes order payload to order detail', () {
    const event = NotificationEvent(
      title: 'Order',
      body: 'Updated',
      route: '/orders/detail',
      entityId: '123',
    );

    final result = router.resolve(event);

    expect(result.destination, NotificationDestination.orderDetail);
    expect(result.entityId, '123');
  });

  test('unknown routes do not crash routing', () {
    const event = NotificationEvent(
      title: 'Unknown',
      body: 'Payload',
      route: '/does-not-exist',
    );

    expect(
      router.resolve(event).destination,
      NotificationDestination.unknown,
    );
  });
}
