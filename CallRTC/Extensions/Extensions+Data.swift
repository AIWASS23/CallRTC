//
//  Extensions+Data.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 01/09/25.
//

import Foundation

extension Data {
    var hexString: String {
        self.map { String(format: "%02x", $0) }.joined()
    }
}
