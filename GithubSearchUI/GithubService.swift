//
//  GithubService.swift
//  GithubSearchUI
//
//  Created by Toseef on 7/26/21.
//

import Foundation
import Combine

struct Repo: Decodable, Identifiable {
    var id: Int
    let name: String
    let description: String
    let fullName: String?
    let htmlUrl: String?
}


struct SearchResponse: Decodable {
    let items: [Repo]
}

class GithubService {

    private let session: URLSession
    private let decoder: JSONDecoder
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
           self.session = session
           self.decoder = decoder
       }

    func search(matching query: String, handler: @escaping (Result<[Repo], Error>) -> Void) {
        guard
            var urlComponents = URLComponents(string: "https://api.github.com/search/repositories")
            else { preconditionFailure("Can't create url components...") }

        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]

        guard
            let url = urlComponents.url
            else { preconditionFailure("Can't create url from url components...") }
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        session.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                handler(.failure(error))
            } else {
                do {
                    let data = data ?? Data()
                    let response = try self?.decoder.decode(SearchResponse.self, from: data)
                    handler(.success(response?.items ?? []))
                } catch {
                    handler(.failure(error))
                }
            }
        }.resume()
    }
}


final class ReposStore: ObservableObject {
    @Published private(set) var repos: [Repo] = []
    @Published var isLoading: Bool = false

    private let service: GithubService
    init(service: GithubService) {
        self.service = service
    }

    func fetch(matching query: String, onfinish: (() -> Void)?) {
        isLoading = true
        service.search(matching: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                print(result)
                switch result {
                case .success(let repos): self?.repos = repos
                case .failure: self?.repos = []
                }
            }
        }
    }
}
