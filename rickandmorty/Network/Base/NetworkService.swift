//
//  NetworkService.swift
//  rickandmorty
//
//  Created by Kamran Bekirov on 27.11.22.
//

import Foundation
import Combine

class NetworkService {
  
  private let session: URLSession
  private let sessionController: SessionController
  private let requestController: RequestController
  
  private var cancellabes = Set<AnyCancellable>()
  
  init() {
    self.sessionController = SessionController()
    self.requestController = RequestController(sessionController: self.sessionController)
    
    self.session = URLSession.shared
    self.session.configuration.timeoutIntervalForRequest = 60
    self.session.configuration.timeoutIntervalForResource = 60
    self.session.configuration.httpShouldSetCookies = false
  }
  
  deinit {
    self.session.invalidateAndCancel()
  }
  
  func request<R: Request, T: Decodable>(request: R, parameters: [Network.Parameter]? = nil) -> AnyPublisher<T?, Error> {
    let urlRequest = prepare(request: request, parameters: parameters)!
    
    return session.dataTaskPublisher(for: urlRequest)
      .receive(on: DispatchQueue.main)
      .tryMap({ [weak self] result in
        let decoder = JSONDecoder()
        
        guard let urlResponse = result.response as? HTTPURLResponse else {
          throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(urlResponse.statusCode) else {
          let apiError = try? decoder.decode(NetworkError.self, from: result.data)
          self?.debugURLRequest(request: urlRequest, response: result.data, statusCode: urlResponse.statusCode)
          throw apiError ?? NetworkError(message: "Status code is not valid.")
        }
        
        if urlResponse.statusCode == 401 {
          throw NetworkError(message: "Unauthorized")
        }
        
        self?.debugURLRequest(request: urlRequest, response: result.data, statusCode: urlResponse.statusCode)
        do {
          return try decoder.decode(T.self, from: result.data)
        } catch {
          error.log()
          return nil
        }
      })
      .tryCatch({ error -> AnyPublisher<T?, Error> in
        if let err = error as? URLError, err.code == .timedOut {
          throw NetworkError(message: "Service time out")
        }
        
        throw error
      })
      .eraseToAnyPublisher()
  }
  
  private func prepare<R: Request>(request: R,
                                   parameters: [Network.Parameter]?) -> URLRequest? {
    guard let baseHost = sessionController.api.enviroment.baseHost else {
      return nil
    }
    
    let endpoint = baseHost.appendingPathComponent(request.path)
    
    var components = URLComponents(url: endpoint,
                                   resolvingAgainstBaseURL: false)
    
    if request.isQuery {
      if let parameters = parameters {
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
      }
    }
    
    guard let url = components?.url else {
      return nil
    }
    
    var urlRequest = URLRequest(url: url)
    
    urlRequest.httpMethod = request.method.rawValue
    
    if !request.isQuery {
      urlRequest.httpBody = Data()
    }
    
    urlRequest = self.requestController.fixedHeaders(request: &urlRequest)
    return urlRequest
  }
}

extension NetworkService {
  private func debugError(error: Error) {
    LogHelper.log("❌ Error: \(error)")
  }
  
  private func debugURLRequest(request: URLRequest, response: Data? = nil, statusCode: Int? = nil) {
    LogHelper.log("1️⃣ Request: " + (request.url?.absoluteString ?? "") )
    LogHelper.log("2️⃣ Http Method: " + (request.httpMethod ?? "") )
    LogHelper.log("3️⃣ HttpBody: " + (request.httpBody?.prettyJson ?? "") )
    LogHelper.log("3️⃣ Headers: ")
    request.allHTTPHeaderFields?.forEach({ key, value in
      LogHelper.log("\(key): \(value)")
    })
    LogHelper.log("4️⃣ Status Code: \(statusCode ?? -1)")
    
    if let response = response {
      LogHelper.log("✅ Response: " + (response.prettyJson ?? "") )
    }
  }
}
