//
//  RequestController.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation

protocol RequestControllerType {
  func fixedHeaders(request: inout URLRequest) -> URLRequest
}

final class RequestController: RequestControllerType {
  
  private let sessionController: SessionControllerType
  
  init(sessionController: SessionControllerType) {
    self.sessionController = sessionController
  }
}

extension RequestController {
  func fixedHeaders(request: inout URLRequest) -> URLRequest {
    sessionController.api.headers.forEach { element in
      request.addValue(element.value, forHTTPHeaderField: element.key)
    }
    if !sessionController.token.isEmpty {
      request.addValue(sessionController.token, forHTTPHeaderField: "Authorization")
    }
    return request
  }
}
