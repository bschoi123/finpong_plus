import 'dart:convert';
import 'dart:io';
import 'package:finpong_plus/finpong_plus.dart';
import 'package:finpong_plus/src/constants/action_code.dart';
import 'package:finpong_plus/src/constants/conf.dart';
import 'package:finpong_plus/src/network/dio_helper.dart';
import 'package:finpong_plus/src/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'constants/check_log_step.dart';
import 'model/finpong_response.dart';
import 'model/result_state.dart';

class FinpongPlusWidget extends StatefulWidget {
  final ServerMode serverMode;
  final String token;
  final String entry;
  final Color backgorundColor;
  final FinpongPlusController? finpongPlusController;
  final Function(String type, String appScheme) onUriScheme;
  final Function(String pageId, String params) onCustomAction;
  final Function() onCloseAction;
  final Function()? onPageLoadStarted;
  final Function()? onPageLoadFinished;

  const FinpongPlusWidget({Key? key,
    required this.token,
    required this.onUriScheme,
    required this.onCustomAction,
    required this.onCloseAction,
    this.finpongPlusController,
    this.entry = '0',
    this.serverMode = ServerMode.staging,
    this.onPageLoadStarted,
    this.onPageLoadFinished,
    this.backgorundColor = Colors.white})
      : super(key: key);

  @override
  State<FinpongPlusWidget> createState() => _FinpongPlusWidgetState();

}

class _FinpongPlusWidgetState extends State<FinpongPlusWidget> {
  WebViewController? _webViewController;
  Color? _initBackgroundColor;
  String _currUrl = '';
  String _homeUrl = '';

  String _clientUuid = '';
  String _userUuid = '';

  Repository repository = Repository();
  bool _isSendLog = false;

  @override
  void initState() {
    serverMode = widget.serverMode;
    DioHelper.init(widget.token);
    _initBackgroundColor = widget.backgorundColor;
    repository.checkLogSend(_clientUuid, _userUuid, widget.entry, CheckLogStep.licenseCheckStart, "");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _initBackgroundColor,
      body: WillPopScope(
        onWillPop: () async {
          if (_homeUrl == _currUrl) {
            widget.onCloseAction();
          } else {
            _webViewController?.canGoBack().then((value) {
              if (value) {
                _webViewController?.goBack();
              } else {
                widget.onCloseAction();
              }
            });
          }
          return false;
        },
        child: FutureBuilder(
            future: Future.wait([
              repository.getLisenceData(widget.entry),
              _getUserAgent(widget.token)
            ]),
            builder: (BuildContext context,
                AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                String userAgent = snapshot.data?[1];
                ResultState<FinpongResponse> response = snapshot.data?[0];
                Widget resultWidget = Container();
                response.when(
                    success: (v) {
                      resultWidget = _finpongWebView(v.data!.returnUrl!, userAgent);
                      _clientUuid = v.data!.clientUuid!;
                      _userUuid = v.data!.apiUserUuid!;
                      repository.checkLogSend(_clientUuid, _userUuid, widget.entry, CheckLogStep.licenseCheckResult, "성공");
                    },
                    loading: () {},
                    error: (code, message, extraMessage) {
                      Fluttertoast.showToast(msg: message);
                      repository.checkLogSend(_clientUuid, _userUuid, widget.entry, CheckLogStep.licenseCheckResult, "실패");
                      if (extraMessage.contains('http')) {
                        resultWidget = _finpongWebView(extraMessage, userAgent);
                      } else {
                        widget.onCloseAction();
                      }
                    });
                return resultWidget;
              } else {
                return Container();
              }
            }),
      ),
    );
  }

  WebViewWidget _finpongWebView(String url, String userAgent) {
    _webViewController = _getWebViewController(url, userAgent);
    widget.finpongPlusController?.webViewController = _webViewController!;
    return WebViewWidget(controller: _webViewController!);
  }

  WebViewController _getWebViewController(String url, String userAgent) {
    repository.checkLogSend(_clientUuid, _userUuid, widget.entry, CheckLogStep.webviewLoadStart, "");
    return WebViewController()
      ..setBackgroundColor(_initBackgroundColor!)
      ..clearLocalStorage()
      ..setUserAgent(userAgent)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..clearCache()
      ..addJavaScriptChannel(Platform.isAndroid ? aosHandleName : iosHandleName,
          onMessageReceived: (onMessageReceived) {
            var jsonData = jsonDecode(onMessageReceived.message);
            var actionCode = jsonData['action_code'];
            var param = jsonData['param'];

            switch (actionCode) {
              case ActionCode.appScheme:
                widget.onUriScheme(param['type'], param['urlscheme']);
                break;
              case ActionCode.customAction:
                widget.onCustomAction(param['pageId'], param['param']);
                break;
              case ActionCode.finpongFinish:
                widget.onCloseAction();
                break;
              case ActionCode.homeUrl:
                _homeUrl = param['homeUrl'];
                break;
            }
          })
      ..setNavigationDelegate(NavigationDelegate(
          onProgress: (progress) {},
          onPageStarted: (url) {
            if (widget.onPageLoadStarted != null) {
              widget.onPageLoadStarted!();
            }
          },
          onPageFinished: (url) {
            if (widget.onPageLoadFinished != null) {
              widget.onPageLoadFinished!();

              if(!_isSendLog){
                _isSendLog = true;
                repository.checkLogSend(_clientUuid, _userUuid, widget.entry, CheckLogStep.webviewLoadResult, "성공");
              }
            }
          },
          onWebResourceError: (e) {
            repository.checkLogSend(_clientUuid, _userUuid, widget.entry, CheckLogStep.webviewLoadResult, "실패");
          },
          onUrlChange: (urlChange) {
            if (urlChange.url != null) {
              _currUrl = urlChange.url!;
            }
          }))
      ..loadRequest(Uri.parse(url));
  }

  Future<String> _getUserAgent(String token) async {
    var userAgent = '';
    userAgent = await InAppWebViewController.getDefaultUserAgent();
    userAgent = '$userAgent;f_token=$token;f_gbn=plus;';
    return userAgent;
  }
}
