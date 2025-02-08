//
//  MQTTManager.swift
//  SwiftMQTTTest
//
//  Created by 김동준 on 2/8/25
//

import Foundation
import CocoaMQTT

class MQTTManager: ObservableObject {
    static let shared = MQTTManager()
    
    private var mqttClient: CocoaMQTT!
    private let myAddress = "myIP"
    private let topic = "test/topic"
    private let port: UInt16 = 1883
    
    @Published var isConnected = false
    @Published var receivedMessage: String = ""
    
    init() {
        setupMQTTClient()
    }
    
    private func setupMQTTClient() {
        mqttClient = CocoaMQTT(clientID: "iphone-client", host: myAddress, port: port)
        mqttClient.keepAlive = 60
        mqttClient.autoReconnect = true
        mqttClient.delegate = self
    }
}

// MARK: Feature
extension MQTTManager {
    func connect() {
        let _ = mqttClient.connect()
    }
    
    func disconnect() {
        mqttClient.disconnect()
    }
    
    func publishMessage(_ message: String) {
        mqttClient.publish(topic, withString: message)
    }
    
    func subscribe() {
        mqttClient.subscribe(topic, qos: .qos1)
    }
}

extension MQTTManager: CocoaMQTTDelegate {
    // 연결 성공
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("## Connected to MQTT broker")
        isConnected = true
    }
    
    // 연결 해제
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        print("## Disconnected from MQTT broker with error: \(String(describing: err))")
        isConnected = false
    }
        
    // 메시지를 발행했을 때
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("## Published message: \(message.string ?? "")")
    }
    
    // 메시지 발행이 확인되었을 때
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("## Message publish acknowledged with id: \(id)")
    }
    
    // 구독한 메시지를 수신했을 때
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        receivedMessage = message.string ?? "No message"
        print("## Received message: \(receivedMessage)")
    }
    
    // 토픽 구독 결과를 받을 때
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        print("## Subscribed topics: \(success), Failed topics: \(failed)")
    }
    
    // 구독을 취소한 토픽 목록을 받을 때
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        print("## Unsubscribed from topics: \(topics)")
    }
    
    // Ping 발생 시
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("## Ping sent to MQTT broker")
    }
    
    // Pong 응답을 받았을 때
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        print("## Pong received from MQTT broker")
    }
}
