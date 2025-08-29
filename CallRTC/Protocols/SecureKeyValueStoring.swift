//
//  SecureKeyValueStoring.swift
//  CallRTC
//
//  Created by Marcelo deAraújo on 29/08/25.
//


import Foundation

protocol SecureKeyValueStoring {
    func save<T: Codable>(_ value: T, for key: KeychainKey) throws
    func load<T: Codable>(_ type: T.Type, for key: KeychainKey) throws -> T
    func delete(for key: KeychainKey) throws
    func exist(key: KeychainKey) -> Bool
}
