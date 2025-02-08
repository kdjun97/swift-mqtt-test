import paho.mqtt.client as mqtt
import time

# MQTT 브로커 정보
# broker = "localhost"  # 또는 Mosquitto가 실행되는 IP 주소
broker = "myIp" 
port = 1883  # 기본 MQTT 포트
topic = "test/topic"  # 구독할 토픽

# MQTT 클라이언트 설정
def on_connect(client, userdata, flags, rc):
    print(f"Connected with result code {rc}")
    # 연결되면 구독 시작
    client.subscribe(topic)

def on_message(client, userdata, msg):
    print(f"Received message: {msg.payload.decode()}")

# MQTT 클라이언트 생성
client = mqtt.Client()

# 연결 이벤트 콜백 함수 설정
client.on_connect = on_connect
client.on_message = on_message

# MQTT 브로커에 연결
client.connect(broker, port, 60)

# 메시지 루프 시작 (구독 및 메시지 처리)
client.loop_start()

# 메시지 구독 후 1초마다 구독 상태를 계속 확인
try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    print("Exiting...")
    client.loop_stop()  # 메시지 루프 종료
    client.disconnect()  # 브로커 연결 종료

