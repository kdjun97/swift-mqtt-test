//
//  ContentView.swift
//  SwiftMQTTTest
//
//  Created by 김동준 on 2/8/25
//

import SwiftUI

struct ContentView: View {
    @StateObject private var mqttManager = MQTTManager()
    @State private var publishMessageString: String = ""

    var isConnected: Bool {
        mqttManager.isConnected
    }
    
    var body: some View {
        VStack {
            sendMessageView
            statusView
            subscribeCheckView
        }
        .padding()
    }
}

private extension ContentView {
    var sendMessageView: some View {
        HStack {
            TextField(
                "보낼 메시지",
                text: $publishMessageString
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            Spacer()
            
            Button {
                sendMessage(publishMessageString)
            } label: {
                Text("Send!!!")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
            }
        }
    }
    
    func sendMessage(_ msg: String) {
        mqttManager.publishMessage(msg)
        publishMessageString = ""
    }
}

private extension ContentView {
    var statusView: some View {
        HStack {
            Text("Status:")
            Text(statusString)
                .foregroundStyle(isConnected ? .blue : .red)
            
            Spacer()
            
            connectButtonView
        }
    }
    
    var statusString: String {
        isConnected
        ? "Connected!"
        : "Disconnected!"
    }
}

private extension ContentView {
    var connectButtonView: some View {
        Button {
            isConnected
            ? mqttManager.disconnect()
            : mqttManager.connect()
        } label: {
            Text(buttonTitle)
                .foregroundStyle(.white)
                .padding()
                .background(isConnected ? .red : .green)
        }
    }
    
    var buttonTitle: String {
        isConnected
        ? "Disconnect"
        : "Try Connect!"
    }
}

private extension ContentView {
    var subscribeCheckView: some View {
        HStack {
            Text("Subscribe:")
            Text(mqttManager.receivedMessage)
            Button {
                mqttManager.subscribe()
            } label: {
                Text("Subscribe my topic")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
            }
        }
    }
}

#Preview {
    ContentView()
}
