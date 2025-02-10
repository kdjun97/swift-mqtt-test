# MQTT 통신 테스트

### 결과 영상  

|**`Python 영상`**|**`아이폰 영상`**|
|:-------------:|:-------------:|
|<img src="https://github.com/kdjun97/swift-mqtt-test/blob/master/Assets/mosquitto.gif?raw=true" width="700" height="300">|<img src="https://github.com/kdjun97/swift-mqtt-test/blob/master/Assets/swift_mqtt.gif?raw=true" width="143" height="300">|

---  

### 개발 환경  

Python: 3.9.6  
paho-mqtt: 2.1.0   
mosquitto: 2.0.20  
Swift: 5.10  
Xcode: 15.4  
CocoaMQTT: 2.1.7  

---  

### 실험과 결과...  

개인 IoT 프로젝트를 위해 몇 가지 검증 사항이 있었음.  
검증 사항은 아래와 같음.  

1. python 환경으로 특정 IP로 Broker 설정이 가능한가?  
2. (1)의 서버로 python 코드에서 topic을 sub, pub이 가능한가?  
3. (1)의 서버로 iPhone이 통신 가능한가?  
4. 아이폰과 python의 코드에서 서로 MQTT로 원활한 통신이 가능한가?  
5. CocoaMQTT 라이브러리는 쓸만한가?  

자료를 찾아봤을 때 이상은 없었으나, 작은 프로젝트로 검증을 먼저 하면 좋겠다 싶어서 본 프로젝트를 만들고 테스트하게 됨.  

**결과**  

✔️ python으로 특정 IP Broker 설정 확인 완료  
✔️ python mosquitto <-> iPhone MQTT 통신(pub,sub) 확인 완료   
✔️ CocoaMQTT 라이브러리 작동 확인 완료  

검증 작업은 성공적으로 완료되었으니 해당 기술로 구상했던 개인 프로젝트에 돌입 예정.  
이하부턴 본 프로젝트의 가벼운 정리 정도 기술..  

---  

### 사용법

1. `mosquitto`, `paho-mqtt` 설치  

```   
brew install mosquitto  
pip install paho-mqtt  
```

MQTT Broker를 위해 mosquitto 설치  
MQTT client 사용을 위해 paho-mqtt 설치 (브로커와 통신을 위해)   

2. Mosquitto Broker 실행  

```  
/opt/homebrew/opt/mosquitto/sbin/mosquitto -c /opt/homebrew/etc/mosquitto/mosquitto.conf  
```  

> **이 시점에 broker 실행.**  

설명 

homebrew로 설치한 Mosquitto 브로커를 실행하는 명령어: `/opt/homebrew/opt/mosquitto/sbin/mosquitto` 
-c: 설정 파일을 지정하여 Mosquitto 실행  
설정 파일 경로: `/opt/homebrew/etc/mosquitto/mosquitto.conf`  

mosquitto.conf 파일을 아래와 같이 설정  

> mosquitto.conf  
> bind_address myIp(123.456.x.x)  
> allow_anonymous true  

bind_address: 특정 IP에서만 접속 허용
allow_anonymous: true -> 인증 필요 없음 , false -> 인증 필요  

**이번 프로젝트에서는 비밀번호 등 다른 보안은 신경쓰지 않음.**  

3. MQTT pub/sub 작업 (python)  

`mqtt_client.py` 실행 -> broker에 연결 + topic 계속 구독  
`mqtt_publish_test.py` 실행 -> broker 연결 후 topic에 publish 작업 , disconnect 과정 진행  

connection, publish와 subscribe 전부 진행하고 있어서 터미널로 mqtt 통신 과정을 볼 수 있음.  

4. Swift 코드 작성  

위 까지 작업이 된다면 아이폰에서도 MQTT pub/sub가 되는지 확인하면 끝.  

CocoaMQTT 라이브러리를 이용하여 **broker**, **topic**, **subscribe**, **publish** 등 각종 설정하여 서로 통신이 되는지 확인(복잡하지 않으므로 코드로 확인)  