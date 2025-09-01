//
//  Endpoint.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//


import Foundation

protocol Endpoint {
    var url: URL { get }
    var method: String { get }
    var headers: [String: String] { get set }
    var body: Data? { get }
}