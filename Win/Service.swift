//
//  Service.swift
//  Win
//
//  Created by Alisher on 09.04.2022.
//

import Foundation
import Alamofire

final class Service {
  static func sendMessage(from: String, to: String, _ completion: @escaping (Result<Void, Error>) -> Void) {
    let url = AppSettings.EndPoint.sendMessage.url
    let parameters: [String: String] = [
      "data": "string",
      "from": from,
      "password": "password",
      "subject": "subject",
      "to": to
    ]
    
    AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: AppSettings.default.headers)
      .responseData { response in
        if let error = response.error {
          print(error)
          completion(.failure(error))
        } else {
          print("\(response.data)")
          completion(.success(()))
        }
      }
  }
}
