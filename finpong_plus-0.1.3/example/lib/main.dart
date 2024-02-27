import 'dart:convert';

import 'package:finpong_plus/finpong_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String sampleToken =
      'oVhMyHYutPW1664VrK3kwYlIlvcQ0QFcW/wwsNmpNZOeTedb0xp3evWclII+mS3+FBPtgf8DCXe5Iv4lnrhnfWU/WFtM3dhEjCHXmTXXTfnLowtwqQWaomifmLryjlxBdhH0nN/AeoRp4kiDuJGenqYzflRiV3RlftUBbBWh0/HjUXOpRedqW+mHmSOAdrEE1KUAtrfFo8/aBlnAwotPXgK62x8ZPJbxCkkHxyOnA4Zgw//TvxzFh6sMCkaRUuqk9J2Vqr4p6eOzmbQ5v7ejwG7ZrlELfv+lXWxE4Tw+34Vf7s8l6mzAtPPK0ad63bPE8tSHk62eS5Vehf42BPNieNaXDtaoDx5o+98ccZCT76UFBXnvmU0hDsHs2lK5Ea25cGrSn/Rb7+WpT7RE/P6RyyV/jf+PAZHmvxzKCf01i0GLwMmMfaXzzlp8tF8Rp9KUFgjwy3jCk3SULltMN1GiH1U1Ku4f3f5Kp5uki3MAgpL1iIs+xsUddSk/cR1y3PjIdd3Q9j58IDNVMl9BZvDMswOCJw30SwmRNTrI+bh7pGnLtZH7R75Z6aVZ0Hc3zL5k';
  String inputToken = '';
  String inputEntry = '';
  FinpongPlusController finpongPlusController = FinpongPlusController();

  TextEditingController tokenInputController = TextEditingController();
  TextEditingController entryInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getPreferencesData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Card(
                child: TextField(
                  controller: entryInputController,
                  onChanged: (text) {
                    setState(() {
                      inputEntry = text;
                    });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'entry'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Card(
                child: TextField(
                  controller: tokenInputController,
                  onChanged: (text) {
                    setState(() {
                      inputToken = text;
                    });
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'token'),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Dev'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => _finpongPlusWidget(
                                inputToken, ServerMode.dev)));
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: Text('Stg'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => _finpongPlusWidget(
                                inputToken, ServerMode.staging)));
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  child: Text('Release'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => _finpongPlusWidget(
                                inputToken, ServerMode.release)));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _finpongPlusWidget(String token, ServerMode serverMode) {
    _savePreferencesData();
    return SafeArea(
      child: FinpongPlusWidget(
        finpongPlusController: finpongPlusController,
        token: token,
        entry: inputEntry,
        serverMode: serverMode,
        backgorundColor: Colors.white,
        onUriScheme: (type, scheme) {
          /**
           * 앱스킴으로 해당 사설 인증앱 실행 코드 작성
           * 앱 미설치일 경우 설치 유도 코드 작성
           */

          // 사설 인증서 호출(앱스킴 실행) 참고용 입니다.
          canLaunchUrl(Uri.parse(scheme)).then((bool result) {
            setState(() async {
              if (result) {
                if (!await launchUrl(Uri.parse(scheme), mode: LaunchMode.externalApplication)) {
                  throw Exception('Could not launch $scheme');
                }
              } else {
                !await launchUrl(
                  Uri.parse('type별 스토어 url'),
                  mode: LaunchMode.externalApplication,
                );
              }
            });
          });
        },
        onCustomAction: (pageId, params) {
          //사전 정의된 핀퐁플러스의 액션을 앱에서 처리를 위함

          // 예시
          if (pageId == 'PA-001') {
            var testData = {"data1": 1, "data2": true};
            String jsonString = jsonEncode(testData);
            finpongPlusController.runJavaScript('fileDataConnect', jsonString);
          }
        },
        onCloseAction: () {
          //핀퐁플러스 닫기
          Navigator.pop(context);
        },
        onPageLoadStarted: () {
          //핀퐁플러스 페이지 로드 시작
        },
        onPageLoadFinished: () {
          //핀퐁플러스 페이지 로드 종료
        },
      ),
    );
  }

  Future<void> _savePreferencesData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', inputToken);
    prefs.setString('entry', inputEntry);
  }

  Future<void> _getPreferencesData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    inputToken = prefs.getString('token') ?? '';
    inputEntry = prefs.getString('entry') ?? '';
    tokenInputController.text = inputToken;
    entryInputController.text = inputEntry;
  }
}
