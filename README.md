# grpc_headers_test

Repo created to test an issue happening with the await of the headers in a ResponseFuture.

## The issue

Per [documentations](https://pub.dev/documentation/grpc/latest/grpc/ResponseFuture/headers.html
), we should be able to await the headers in any give ResponseFuture call.

However when the call is not implemented, the code hangs indefinetly without completing.

### Sample
Usint the following code I espect to always have a print at some point
```dart
Future<void> testService() async {
    try {
      final client = MyService.instance.client;
      final request = TestRequest(name: "Test");
      final responseFuture = client.sayHello(request);
    
      var header = await responseFuture.headers; //ISSUE IN THIS LINE
      var helloResponse = await responseFuture;
    
      print(helloResponse.message);
    } catch (e) {
      print(e);
    }
}
```
But in reality what is happening is that the `await responseFuture.headers;` never completes, hanging this future indefinitely

This project is created to test this case, it defines a sample proto and it already include the generated file for convenience inside `lib/services` it includes a Simple application that shows a button to call the service and await for the result.

### How to test
1. Clone this repo
2. On the root directory run the project, by using `flutter run` on the console for your device of choice
3. Tap on the `Send request` button.

#### Expected result
A loader is briefly shown, then a error is shown in the text over the button indicating the service is not available.

#### Actual result
The loader never goes away because the `var header = await responseFuture.headers;` at line 59 of main.dart never completes.

### Extra info
Running on web I get the following log, showing that something failed asyncronously but it is not rethrown/catched
```
Error
dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/errors.dart 329:10  createErrorWithStack
dart-sdk/lib/_internal/js_dev_runtime/patch/core_patch.dart 265:28            _throw
dart-sdk/lib/core/errors.dart 120:5                                           throwWithStackTrace
dart-sdk/lib/async/zone.dart 1386:11                                          callback
dart-sdk/lib/async/schedule_microtask.dart 40:11                              _microtaskLoop
dart-sdk/lib/async/schedule_microtask.dart 49:5                               _startMicrotaskLoop
dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 181:7            <fn>
```