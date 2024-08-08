import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_header_test/sample_service.dart';
import 'package:grpc_header_test/services/sample.pb.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SampleService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String request = "No request done";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            loading ? CircularProgressIndicator() : Text(request),
            ElevatedButton(
              onPressed: testService,
              child: Text("Send request"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> testService() async {
    setState(() => loading = true);
    try {
      final sampleClient = SampleService.instance.sampleClient;
      final helloRequest = SampleRequest(name: "Test");
      final responseFuture = sampleClient.sayHello(helloRequest);

      var header = responseFuture.headers;
      var helloResponse = await responseFuture;

      request = helloResponse.message;
    } on GrpcError catch (e) {
      request = e.toString();
    } catch (e) {
      request = e.toString();
    } finally {
      setState(() => loading = false);
    }
  }
}
