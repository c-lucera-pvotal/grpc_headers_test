//
//  Generated code. Do not modify.
//  source: sample.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'sample.pb.dart' as $0;

export 'sample.pb.dart';

@$pb.GrpcServiceName('Sample')
class SampleClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<$0.SampleRequest, $0.SampleResponse>(
      '/Sample/SayHello',
      ($0.SampleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SampleResponse.fromBuffer(value));

  SampleClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.SampleResponse> sayHello($0.SampleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }
}

@$pb.GrpcServiceName('Sample')
abstract class SampleServiceBase extends $grpc.Service {
  $core.String get $name => 'Sample';

  SampleServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SampleRequest, $0.SampleResponse>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SampleRequest.fromBuffer(value),
        ($0.SampleResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.SampleResponse> sayHello_Pre($grpc.ServiceCall call, $async.Future<$0.SampleRequest> request) async {
    return sayHello(call, await request);
  }

  $async.Future<$0.SampleResponse> sayHello($grpc.ServiceCall call, $0.SampleRequest request);
}
