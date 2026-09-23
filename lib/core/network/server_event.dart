class ServerEvent {
  final String type;
  final Map<String, dynamic> data;

  const ServerEvent(this.type, [this.data = const {}]);
}
