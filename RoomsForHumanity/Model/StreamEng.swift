//
//  StreamEng.swift
//  RoomsForHumanity
//
//  Created by Jocelyn Ragukonis on 10/3/18.
//  Copyright © 2018 Jocelyn Ragukonis. All rights reserved.
//

import Foundation
import SocketIO
import WebRTC

class StreamEng: NSObject {
    static let sharedInstance = StreamEng()
    
    var connectionFactory: RTCPeerConnectionFactory
    var iceServers: [RTCIceServer] = []
    var peers: [String] = []
    fileprivate var peerConnection: RTCPeerConnection?
    fileprivate let defaultConnectionConstraint = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: ["DtlsSrtpKeyAgreement": "true"])
    
    //var iceServers: [RTCIceServer] = []
//    var videoCapturer: RTCVideoCapturer
//    var constraints: RTCMediaConstraints
//    var localStream: RTCMediaStream
//    var videoSource: RTCVideoSource
//    var videoTrack: RTCVideoTrack
    
    
    override init() {
        self.connectionFactory = RTCPeerConnectionFactory()
        iceServers.append(RTCIceServer(urlStrings: ["stun:stun.l.google.com:19302"], username: "", credential: ""))
        iceServers.append(RTCIceServer(urlStrings: ["turn:numb.viagenie.ca"], username: "bethin.charles@yahoo.com", credential: "enter1234"))
        super.init()
    }

}
