import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';

class SignalRService {
  final String _baseUrl;
  final String _hubName;
  final String _token;
  WebSocketChannel? _channel;
  String? _connectionId;
  final Map<String, Function(dynamic)> _handlers = {};
  final StreamController<Map<String, dynamic>> _messageStream =
      StreamController.broadcast();

  SignalRService({
    required String baseUrl,
    required String hubName,
    required String token,
  }) : _baseUrl = baseUrl,
       _hubName = hubName,
       _token = token;

  Stream<Map<String, dynamic>> get messageStream => _messageStream.stream;

  Future<void> connect() async {
    // 1. Negotiate with server to get connection details
    final negotiateUrl = '$_baseUrl/$_hubName/negotiate?negotiateVersion=1';
    final response = await http.post(
      Uri.parse(negotiateUrl),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to negotiate: ${response.body}');
    }

    final negotiateResponse = jsonDecode(response.body);
    _connectionId = negotiateResponse['connectionId'];

    // 2. Establish WebSocket connection
    final wsUrl =
        '$_baseUrl/$_hubName'
        '?id=$_connectionId'
        '&access_token=$_token';

    _channel = WebSocketChannel.connect(
      Uri.parse(
        wsUrl
            .replaceFirst('https://', 'wss://')
            .replaceFirst('http://', 'ws://'),
      ),
    );

    // 3. Listen for messages
    _channel!.stream.listen(
      (message) {
        final data = jsonDecode(message);
        if (data is List && data.length == 1) {
          final messageData = data[0];
          if (messageData['type'] == 1) {
            // Invocation message
            final target = messageData['target'];
            final arguments = messageData['arguments'];
            if (_handlers.containsKey(target)) {
              _handlers[target]!(arguments);
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
