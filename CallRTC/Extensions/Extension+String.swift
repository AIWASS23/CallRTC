//
//  Extension+String.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//

import Foundation

extension String {
    var isJWTExpired: Bool {
        guard
            let payload = self.decodeJWTPayload(),
            let exp = payload["expiration"] as? TimeInterval
        else {
            return true
        }
        
        let expiryDate = Date(timeIntervalSince1970: exp)
        return expiryDate < Date()
    }
    
    func decodeJWTPayload() -> [String: Any]? {
        let segments = self.split(separator: ".")
        guard segments.count > 1 else { return nil }
        
        let payloadSegment = segments[1]
        
        var base64 = String(payloadSegment)
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        let paddedLength = (4 - (base64.count % 4)) % 4
        base64 += String(repeating: "=", count: paddedLength)
        
        guard let payloadData = Data(base64Encoded: base64) else {
            return nil
        }
        
        let json = try? JSONSerialization.jsonObject(with: payloadData, options: [])
        return json as? [String: Any]
    }
}
