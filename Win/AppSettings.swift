//
//  AppSettings.swift
//  Win
//
//  Created by Alisher on 09.04.2022.
//

import Foundation
import Alamofire

final class AppSettings {
  static let `default` = AppSettings()
  private let persistance = UserDefaults.standard
  
  var headers: HTTPHeaders = [
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
    static let baseURL = URL(string: "http://b247-178-91-253-72.ngrok.io")!
    
    case sendMessage
    
    var url: URL {
      switch self {
      case .sendMessage:
        return EndPoint.baseURL.appendingPathComponent("/mail")
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
