import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safe_bus/features/shared/login/data/repo/login_repo.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';

class SignalRService {
  final String _baseUrl;
  final String _hubName;
  WebSocketChannel? _channel;
  String? _connectionId;
  final Map<String, Function(dynamic)> _handlers = {};
  final StreamController<Map<String, dynamic>> _messageStream =
      StreamController.broadcast();

  SignalRService({required String baseUrl, required String hubName})
    : _baseUrl = baseUrl,
      _hubName = hubName;

  Stream<Map<String, dynamic>> get messageStream => _messageStream.stream;

  Future<void> connect() async {
    // 1. Negotiate with server to get connection details
    String? token = await LoginRepo.instance.getToken();
    final negotiateUrl =
        'https://safe-api-hbgkbrbwaqh0g6ge.eastus2-01.azurewebsites.net/$_hubName/negotiate?negotiateVersion=1';
    final response = await http.post(
      Uri.parse(negotiateUrl),
      //headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to negotiate: ${response.body}');
    }

    final negotiateResponse = jsonDecode(response.body);
    _connectionId = negotiateResponse['connectionId'];

    // 2. Establish WebSocket connection
    String wsUrl = '$_baseUrl/$_hubName';
    //'?id=$_connectionId';
    //'&access_token=$token';

    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    // 3. Listen for messages
    _channel!.stream.listen(
      (message) {
        if (message is! String) {
          message = utf8.decode(message);
        }

        if (message.endsWith('\u001e')) {
          message = message.substring(0, message.length - 1);
        }

        final data = jsonDecode(message);
        if (data["type"] != null) {
          if (data['type'] == 1) {
            // Invocation message
            //{type: 1, target: LocationUpdated, arguments: [{busRouteId: 1, latitude: 31.993227496908702, longitude: 35.93561771597489, speed: 15, bearing: 0, timestamp: 2023-11-15T14:30:45.123456}]}
            final target = data['target'];
            final arguments = data['arguments'];
            if (_handlers.containsKey(target)) {
              _handlers[target]!(arguments?.first);
            }
            _messageStream.add({
              'type': 'invocation',
              'target': target,
              'arguments': arguments,
            });
          }
        }
      },
      onError: (error) {
        _messageStream.addError(error);
        _reconnect();
      },
      onDone: () => _reconnect(),
    );

    // 4. Send handshake
    final handshake = jsonEncode({'protocol': 'json', 'version': 1});
    _channel!.sink.add('$handshake\u001e');
  }

  Future<void> invoke(String methodName, [List<dynamic>? arguments]) async {
    if (_channel == null) {
      await connect();
    }

    final invocation = {
      'type': 1,
      'invocationId': const Uuid().v4(),
      'target': methodName,
      'arguments': arguments ?? [],
    };

    _channel!.sink.add('${jsonEncode(invocation)}\u001e');
  }

  void on(String methodName, Function(dynamic) handler) {
    _handlers[methodName] = handler;
  }

  Future<void> _reconnect() async {
    await Future.delayed(const Duration(seconds: 5));
    await disconnect();
    await connect();
  }

  Future<void> disconnect() async {
    await _channel?.sink.close();
    _channel = null;
  }
}
