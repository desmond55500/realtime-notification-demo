class NotificationEvent {
  const NotificationEvent({
    required this.title,
    required this.body,
    required this.route,
    this.entityId,
  });

  final String title;
  final String body;
  final String route;
  final String? entityId;

  factory NotificationEvent.fromData(Map<String, dynamic> data) {
    return NotificationEvent(
      title: data['title']?.toString() ?? 'Notification',
      body: data['body']?.toString() ?? '',
      route: data['route']?.toString() ?? '/',
      entityId: data['entity_id']?.toString(),
    );
  }
}
