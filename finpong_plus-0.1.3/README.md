# finpong_plus

HectoData MyData Platform FinpongPlus

## Getting Started

[Finpong Guide](https://guide.finpong.com/)


* FinpongPlus를 적용 하시려면 먼저 <a href="#">ClientId와 Secure Code를 발급</a> 받으셔야 합니다. 
  
---  

# 1. 사전준비

* <a href="https://pub.dev/packages/finpong_plus">package link</a> 최신버전 확인
* 사설 인증앱에서 인증 완료 후 나의 앱으로 복귀를 위해 IOS, AOS 각 scheme값 설정 필수

## 1.1  pubspec.yaml 추가
* 서비스 앱 pubspec.yaml 의  dependencies에 추가합니다.

```yaml
dependencies:
  finpong_plus: ^x.y.z
```  
또는 터미널에서
 ```shell
 $ flutter pub add finpong_plus
```


## 1.2  앱 스키마 등록
* 핀퐁플러스에서 인증 앱(네이버, 카카오 등)으로 이동하여 인증 완료 후 기존 핀퐁플러스 화면으로 복귀를 위해 OS별 앱 스키마를 등록해 줍니다. 

  - Android - AndrdoidManifest.xml 파일  
    + 사용 할 activity 태그 하위에 아래와 같이 설정합니다. ex) MainActivity  
    
        ```manifest
        <manifest xmlns:android="http://schemas.android.com/apk/res/android">
            <application
                ...    >
                <activity
                    android:name=".MainActivity"
                    android:exported="true"
                    ...    >
                
                    <intent-filter>
                        <action android:name="android.intent.action.VIEW"/>
                        <category android:name="android.intent.category.DEFAULT"/>
                        <category android:name="android.intent.category.BROWSABLE"/>
                        <data android:scheme="사용할 앱 스킴을 입력해 주세요." />
                    </intent-filter>
                
                </activity>
                
                ...
                
            </application>
        </manifest>
        ```

  - IOS - info.plist 파일
    + CFBundleURLTypes에 사용할 앱 스킴을 설정합니다. 
    + LSApplicationQueriesSchemes에 간편인증 앱 실행을 위한 인증 앱 스킴을 설정합니다.  
    
      ```
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
    
          ...
    
          <!-- 간편인증 후 돌아오기 위한 앱 스킴 등록 -->    
          <key>CFBundleURLTypes</key>
          <array>
              <dict>
                  <key>CFBundleTypeRole</key>
                  <string>Editor</string>
                  <key>CFBundleURLName</key>
                  <string>com.finpong.finpongPlusExample</string>
                  <key>CFBundleURLSchemes</key>
                  <array>
                      <string>사용할 앱 스킴을 입력해 주세요.</string>
                  </array>
              </dict>
          </array>
        
          <!-- 간편인증을 하기 위한 앱 등록 -->
          <key>LSApplicationQueriesSchemes</key>
          <array>
              <string>naversearchthirdlogin</string>
              <string>supertoss</string>
              <string>finpongapp</string>
              <string>tauthlink</string>
              <string>ktauthexternalcall</string>
              <string>upluscorporation</string>
              <string>kakaotalk</string>
          </array>
          ...
        
      </dict>
      </plist>
      ```

# 2. FinpongPlus 실행하기

## 2.1 Application 에 아래의 내용을 추가합니다.
* FinpongPlusWidget을 원하는 위치에 생성합니다.
* 반드시 token을 발급 받아야 합니다.


 ```dart
 import 'package:finpong_plus/finpong_plus.dart';
 
	FinpongPlusWidget(  
			  token: 'eyJ0e...QINWU',
              finpongPlusController: finpongPlusController,
			  entry: '1',  
			  serverMode: ServerMode.staging,  
			  backgorundColor: Colors.white,  
			  onUriScheme: (type, scheme) {  
			  //사설 인증서 호출 (앱스킴 실행)  
			  },  
			  onCustomAction: (pageId, params) {  
			  //사전 정의된 핀퐁플러스의 액션을 앱에서 처리를 위함  
			  },  
			  onCloseAction: () {  
			  //핀퐁플러스 닫기  
			  },  
			  onPageLoadStarted: () {  
			  //핀퐁플러스 페이지 로드 시작  
			  },  
			  onPageLoadFinished: () {  
			  //핀퐁플러스 페이지 로드 종료  
			  },  
	)
```


## 필수(required)
- **token** :String -  발급 받은 token 값을 입력
- **onUriScheme**(String type, String appScheme) - 핀퐁플러스에서 사설 인증서 앱 호출
- **onCustomAction**(String pageId, String params) - 사전 정의된 핀퐁플러스 액션을 처리
- **onCloseAction**( ) - 핀퐁플러스에서 종료 이벤트 발생

## 선택(optional)
- **entry** :String - 초기 페이지를 설정 **(2.2 참고)**
- **serverMode** :ServerMode - **release, staging** 2가지 모드를 설정 가능  **(2.3 참고)**
- **backgorundColor**:Color - 실행시 기본적으로 적용될 배경색을 적용
- **onPageLoadStarted**( ) - 페이지 로드 시작 이벤트
- **onPageLoadFinished**( ) - 페이지 로드 종료 이벤트




## 2.2 entry 설명

| entry | 진입 페이지 | 예시 |  
|--|--|--|  
| `"0"` | 기본(default) 페이지 | 업권 메인페이지 (마이보험, 마이투자) |
| `"1"` | 설정된 커스텀 페이지 | 마이데이터 연동관리 페이지 |
* 단, 해당 계정이 최초로 접근하여 약관동의를 하지 않았을 경우 entry 값과 관계없이 서비스 및 약관 동의 페이지로 이동합니다.
* 커스텀하게 추가 가능합니다.
## 2.3 ServerMode 설명

| mode | 내 용 | URL|  
|--|--|--|   
| `staging` | Staging Page (개발 진행 시) | `tapi.finpong.com` |  
| `release` | Product Page (운영 시) | `api.finpong.com` |  



# 3. 사설인증서 호출하기

<table>
<tr>
    <th>Android</th>
    <th>IOS</th>
</tr>

<tr>
<td>

| 간편인증 기관 | type(String) | packageName(String)|
|--|--|--|  
| `네이버`| `1` | `com.nhn.android.search`|
| `토스`  | `3` | `viva.republica.toss`|
| `핀퐁`  | `4` | `com.finpong.app`|
| `PASS(SKT)`  | `5` | `com.sktelecom.tauth`|
| `PASS(KT)`  | `6` | `com.kt.ktauth`|
| `PASS(LG)`  | `7` | `com.lguplus.smartotp`|
| `카카오`  | `9` | `com.kakao.talk`|

</td>
<td>

| 간편인증 기관 | type(String) | appId(String) |
|--|--|--|  
| `네이버`| `1` | `393499958` |  
| `토스`  | `3` | `839333328` |  
| `핀퐁`  | `4` | `1611667407` |
| `PASS(SKT)`  | `5` | `1141258007` |
| `PASS(KT)`  | `6` | `1134371550` |
| `PASS(LG)`  | `7` | `1147394645` |
| `카카오`  | `9` | `362057947` |

</td>
</tr>
</table>

### 3.1 아래의 내용을 추가 합니다.   (인증 앱의 스킴값을 받아 실행시키거나, 미설치시 설치 페이지로 이동하도록 합니다)

```dart  
	onUriScheme: (type, scheme) {  
		/**  
		 * todo  
		 * 앱스킴으로 해당 사설 인증앱 실행 코드 작성  
		 * 앱 미설치일 경우 설치 유도 코드 작성  
		 */
	}
 ```  
* 사설 인증앱에서 인증 완료 후 나의 앱으로 복귀를 위해 IOS, AOS 각 scheme값 설정하여야 합니다.

# 4. FinpongPlus와 Application 통신하기


### 4.1 아래 내용을 추가 합니다. (사전에 협의된 커스텀 동작 및 이벤트를 추가합니다)

 ```dart  
		onCustomAction: (pageId, params) {  
		  //사전 정의된 핀퐁플러스의 액션을 앱에서 처리  
		  switch(pageId){  
		  case 'ACT1000':  
		      //ACT1000으로 정의한 액션을 받고 param으로 json 데이터를 받음  
		  break;
		  case 'ACT2000':
		      //toDo
		  break;  
		  ...  
		  }  
		}
```  
(!) **ACT1000**: FinpongPlus의 버튼ID를 ACT1000 으로 정의 한 경우.  
(!) **ACT2000**: FinpongPlus의 버튼ID를 ACT2000 으로 정의 한 경우.   

### 4.2 FinpongPlus Script 호출
FinpongPlusWidget 생성시 **FinpongPlusController** 를 생성하여 추가 해줍니다.
 ```dart    
      FinpongPlusWidget(    
        token: 'eyJ0e...QINWU',  
		finpongPlusController: finpongPlusController,
		...
``` 

필요시 runJavaScript 실행.
 ```dart    
      var testData = {"data1": 1, "data2": true};
      String jsonString = jsonEncode(testData);
      
      finpongPlusController.runJavaScript('scriptName',jsonString);
``` 

### 4.3 파일 다운로드 / 업로드

* **파일다운로드 & 업로드 가이드**  
사전 작업 : 업로드 팝업(업로드 동의/비동의 선택 팝업)을 고객사에서 제작합니다.
* 웹뷰 내에서 파일데이터를 다운받고, 업로드 처리 후 업로드 결과값을 핀퐁플러스로 전달합니다.


1) onCustomAction pageId값이 PA-001로 들어왔을때 고객사 업로드 팝업을 호출합니다.
2) 고객사 업로드 팝업에서 동의 선택시 동의여부값을 전달합니다. finpongPlus의 fileDataConnect 함수 호출  
* 다운로드 한 데이터가 전달됩니다. (pageId : FD-001)

 ```dart    
      var testData = {
        isUpload:false,     // 업로드 여부 N
        uploadRes:'',
        uploadMsg:'',
        isAgree : 'Y'.     // 동의 여부 Y
      }

      String jsonString = jsonEncode(testData);

      finpongPlusController.runJavaScript('fileDataConnect',jsonString);
```
3) 다운로드 데이터를 받아 고객사에서 업로드 처리 후 업로드 결과값을 전달합니다. finpongPlus의 fileDataConnect 함수 호출

```dart    
      var testData = {
        isUpload:true,     // 업로드 여부 Y
        uploadRes:'success',      // 업로드 성공 여부 코드 : 성공(success) /실패(fail) 
        uploadMsg:'업로드 성공하였습니다',  // 업로드 결과 메세지 (성공, 실패 메세지)
        isAgree : 'Y'
      }
    
      String jsonString = jsonEncode(testData);
    
      finpongPlusController.runJavaScript('fileDataConnect',jsonString);
```
