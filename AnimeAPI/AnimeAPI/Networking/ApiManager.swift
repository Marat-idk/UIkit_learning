//
//  AnimeApiManager.swift
//  AnimeAPI
//
//  Created by Marat on 05.01.2023.
//

import Foundation

enum AnimeApiError: Error {
    case invalidURL
    case noDataAvailable
    case canNotProcessData
}

enum AnimeApi: String {
    // сслыка на api с аниме текущего сезона
    case link = "https://api.jikan.moe/v4/seasons/now"
}

class ApiManager {
    private init() {}
    
    static let shared = ApiManager()
    let session = URLSession.shared
    
    // запрос к апи за списком аниме
    func getAnimeList(completion: @escaping(Result<SeasonAnime, AnimeApiError>) -> Void) {
        guard let url = URL(string: AnimeApi.link.rawValue) else {
            completion(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let animeList = try decoder.decode(SeasonAnime.self, from: data)
                completion(.success(animeList))
            } catch {
                completion(.failure(.canNotProcessData))
            }

        }
        dataTask.resume()
    }
}
