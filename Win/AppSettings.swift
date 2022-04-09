//
//  AppSettings.swift
//  Win
//
//  Created by Alisher on 09.04.2022.
//

import Foundation

final class AppSettings {
  static let `default` = AppSettings()
  private let persistance = UserDefaults.standard
  
  var headers: [String: String] = [
    "accept": "application/json",
    "Content-Type": "application/json"
  ]
  
  var from: String? {
    get { return persistance.string(forKey: Keys.from) }
    set { return persistance.set(newValue, forKey: Keys.from) }
  }
  
  var to: String? {
    get { return persistance.string(forKey: Keys.to) }
    set { return persistance.set(newValue, forKey: Keys.to) }
  }

}

extension AppSettings {
  enum EndPoint {
    static let baseURL = URL(string: "https://api.example.kz/v1/")!
    
    case sendMessage
    
    var url: URL {
      switch self {
      case .sendMessage:
        return EndPoint.baseURL.appendingPathComponent("send")
      }
    }
  }
}

extension AppSettings {
  enum Keys {
    static let from = "from"
    static let to = "to"
  }
}
