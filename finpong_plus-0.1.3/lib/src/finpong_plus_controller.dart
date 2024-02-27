import 'package:webview_flutter/webview_flutter.dart';

class FinpongPlusController {
  late WebViewController webViewController;

  void runJavaScript(String name, String data) {
    webViewController.runJavaScript("$name('$data')");
  }
}
