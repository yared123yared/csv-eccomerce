import 'package:app/models/client.dart';

class ClientEditArgs{
   final Client? client;
   final String from;
  ClientEditArgs({
    this.client,
    required this.from,
  });
}