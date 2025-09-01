//
//  PushRegistryManaging.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import PushKit

protocol PushRegistryManaging {
    var delegate: PKPushRegistryDelegate? { get set }
    var desiredPushTypes: Set<PKPushType>? { get set }
}