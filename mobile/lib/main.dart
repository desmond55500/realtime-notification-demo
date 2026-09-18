import 'package:flutter/material.dart';

import 'notification_event.dart';
import 'notification_router.dart';

void main() {
  runApp(const NotificationDemoApp());
}

class NotificationDemoApp extends StatelessWidget {
  const NotificationDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006C4C)),
      ),
      home: const NotificationLabScreen(),
    );
  }
}

class NotificationLabScreen extends StatefulWidget {
  const NotificationLabScreen({super.key});

  @override
  State<NotificationLabScreen> createState() => _NotificationLabScreenState();
}

class _NotificationLabScreenState extends State<NotificationLabScreen> {
  final router = NotificationRouter();
  String lastRoute = 'No notification opened yet';

  void simulateOrderNotification() {
    const event = NotificationEvent(
      title: 'Order update',
      body: 'Your order is on the way.',
      route: '/orders/detail',
      entityId: 'order-42',
    );

    final result = router.resolve(event);

    setState(() {
      lastRoute =
          'Destination: ' + result.destination.name +
          '\nEntity: ' + (result.entityId ?? 'none');
    });
  }

  void simulateWalletNotification() {
    const event = NotificationEvent(
      title: 'Wallet funded',
      body: 'Your wallet balance has been updated.',
      route: '/wallet',
    );

    final result = router.resolve(event);

    setState(() {
      lastRoute = 'Destination: ' + result.destination.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Routing Lab')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Push notifications should open the intended screen, not just the app.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          const Text(
            'This demo keeps routing logic in one testable class. In production, Firebase Messaging callbacks can convert payload data into NotificationEvent and pass it to the same router.',
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: simulateOrderNotification,
            icon: const Icon(Icons.local_shipping_outlined),
            label: const Text('Simulate order notification'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: simulateWalletNotification,
            icon: const Icon(Icons.account_balance_wallet_outlined),
            label: const Text('Simulate wallet notification'),
          ),
          const SizedBox(height: 28),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(lastRoute),
            ),
          ),
        ],
      ),
    );
  }
}
