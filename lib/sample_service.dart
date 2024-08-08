import 'package:grpc/grpc.dart';

import 'services/sample.pbgrpc.dart';

class SampleService {
  ///here enter your host without the http part (e.g enter google.com now http://google.com)
  String baseUrl = "example.com";

  SampleService._internal();
  static final SampleService _instance = SampleService._internal();

  factory SampleService() => _instance;

  ///static SampleService instance that we will call when we want to make requests
  static SampleService get instance => _instance;

  ///SampleClient is the  class that was generated for us when we ran the generation command
  ///We will pass a channel to it to intialize it
  late SampleClient _sampleClient;

  ///this will be used to create a channel once we create this class.
  ///Call SampleService().init() before making any call.
  Future<void> init() async {
    _createChannel();
  }

  ///provide public access to the SampleClient instance
  SampleClient get sampleClient {
    return _sampleClient;
  }

  ///here we create a channel and use it to initialize the SampleClientthat was generated
  ///
  _createChannel() {
    final channel = ClientChannel(
      baseUrl,

      ///port: 9043,
      port: 443,

      ///use credentials: ChannelCredentials.insecure() if you want to connect without Tls
      //options: const ChannelOptions(credentials: ChannelCredentials.insecure()),

      ///use this if you are connecting with Tls
      options: const ChannelOptions(),
    );
    _sampleClient = SampleClient(channel);
  }
}
