import paho.mqtt.client as mqtt

# MQTT 브로커 정보
broker = "myIp"  # Mosquitto가 실행되고 있는 IP 주소
port = 1883  # MQTT 포트

# 메시지 발행 (publish)
client = mqtt.Client()

client.connect(broker, port, 60)

# 발행할 토픽과 메시지
topic = "test/topic"
message = "Hello, MQTT!"

# 메시지 발행
client.publish(topic, message)
print(f"Message '{message}' published to topic '{topic}'")

# 연결 종료
client.disconnect()

