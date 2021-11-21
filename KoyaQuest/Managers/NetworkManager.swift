//
//  NetworkManager.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/22.
//

import UIKit

enum APError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case invalidSomething
    case unableToComplete
}

final class NetworkManager {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    static let baseURL = "https://www.collins-sweet.com/kq/backend/json/"
    private let infoURL = baseURL + "Information.json"
    private let landmarksURL = baseURL + "Landmarks.json"
    private let FAQURL = baseURL + "FAQ2.json"
    private init() {
    }
    // problem: how to pass params (Result<[???]> , and url string required for each
    func getInfo(completed: @escaping (Result<[Information], APError>) -> Void ) {
        guard let url = URL(string: infoURL) else {
            completed(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode([Information].self, from: data)
                completed(.success(decodedResponse))

            } catch {
                completed(.failure(.invalidSomething))
            }
        }
        task.resume()
    }

    func getFAQ(completed: @escaping (Result<[FAQ], APError>) -> Void ) {
        guard let url = URL(string: FAQURL) else {
            completed(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                // let decodedResponse = try decoder.decode(FAQResponse.self, from: data)
                // completed(.success(decodedResponse.request))
                let decodedResponse = try decoder.decode([FAQ].self, from: data)
                completed(.success(decodedResponse))

            } catch {
                completed(.failure(.invalidSomething))
            }
        }
        task.resume()
    }
}
