//
//  Client.swift
//  
//
//  Created by Oleh Kiurchev on 29.01.2023.
//

import Foundation
import Get

public class Client {
    private static var sharedApiKey = ""
    public static let shared = Client(apiKey: sharedApiKey)
    
    static public func setSharedApiKey(_ apiKey: String) {
        self.sharedApiKey = apiKey
    }

    private var client: APIClient

    public init?(apiKey: String, _ configure: (inout APIClient.Configuration) -> Void = { _ in }) {
        guard !apiKey.isEmpty else {
            return nil
        }
    
        var configuration = APIClient.Configuration(baseURL: URL(string: "https://api.openweathermap.org/"))
        configure(&configuration)
        
        configuration.delegate = ClientDelegate(apiKey: apiKey)

        self.client = APIClient.init(configuration: configuration)
    }
    
    @discardableResult public func send<T: Decodable>(
        _ request: Request<T>,
        delegate: URLSessionDataDelegate? = nil,
        configure: ((inout URLRequest) throws -> Void)? = nil
    ) async throws -> Response<T> {
        try await self.client.send(request, delegate: delegate, configure: configure)
    }
}

class ClientDelegate: APIClientDelegate {
    var apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
        if let originalUrl = request.url,
           var components = URLComponents(url: originalUrl, resolvingAgainstBaseURL: false) {
            if components.queryItems == nil {
                components.queryItems = []
            }

            components.queryItems!.append(URLQueryItem(name: "appid", value: apiKey))

            request.url = components.url
        }
    }
}
