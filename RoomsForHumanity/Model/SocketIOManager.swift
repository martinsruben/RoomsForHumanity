//
//  ServerConnection.swift
//  RoomsForHumanity
//
//  Created by Jocelyn Ragukonis on 10/2/18.
//  Copyright © 2018 Jocelyn Ragukonis. All rights reserved.
//

import Foundation
import SocketIO
import Starscream

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()

    var streamURL: URL
    var manager: SocketManager
    var socket: SocketIOClient
    
    override init() {
        self.streamURL = URL(string: "https://stream.roomsforhumanity.org")!
        self.manager = SocketManager(socketURL: self.streamURL)
        self.socket = self.manager.defaultSocket
        
        super.init()
    }
    
    func establishConnection () {
        self.socket.connect()
    }
    
    func closeConnection () {
        self.socket.disconnect()
    }
    
    func publish(userID: String, roomName: String) {
        self.socket.emit("publish", userID, roomName)
        self.socket.on("publisher ready") {data, ack in print(data)}
    }
    
    func subscribe(userID: String, roomName: String) {
        self.socket.emit("subscribe", userID, roomName)
        self.socket.on("subscriber ready") {data, ack in print(data)}
    }
    
    func socketHandler () {
        socket.on("connect") {data, ack in
            print("SOCKET CONNECTED")
        }
        
        self.socket.onAny{print("got event: \($0.event) with items \(String(describing: $0.items))")}
    }
    
    func createUserID() -> String {
        // Creates a random userID of 16 characters and returns the random userID
        
        let length = 16
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
    
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        print("User ID: ", randomString)
        return randomString
    }
    
}
