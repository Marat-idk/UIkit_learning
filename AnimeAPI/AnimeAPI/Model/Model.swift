//
//  Model.swift
//  AnimeAPI
//
//  Created by Marat on 05.01.2023.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let anime = try? JSONDecoder().decode(SeasonAnime.self, from: jsonData)

// MARK: - SeasonAnime - класс списка аниме текущего сезона
struct SeasonAnime: Codable {
    let anime: [Anime]?
    
    enum CodingKeys: String, CodingKey {
        case anime = "data"
    }
}

// MARK: - DataClass
struct Anime: Codable {
    let malID: Int?
    let url: String?
    let images: Images?
    let approved: Bool?
    let titles: [Title]?
    let title, titleEnglish, titleJapanese, type: String?
    let source: String?
    let episodes: Int?
    let status: String?
    let airing: Bool?
    let aired: Aired?
    let duration, rating: String?
    let score: Double?
    let scoredBy, rank, popularity, members: Int?
    let favorites: Int?
    let synopsis, season: String?
    let year: Int?
    let broadcast: Broadcast?
    let producers, studios, genres, themes: [Demographic]?
    let demographics: [Demographic]?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url, images, approved, titles, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case type, source, episodes, status, airing, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, season, year, broadcast, producers, studios, genres, themes, demographics
    }
}

// MARK: - Aired
struct Aired: Codable {
    let from, to: String?
    let prop: Prop?
    let string: String?
}

// MARK: - Prop
struct Prop: Codable {
    let from, to: From?
}

// MARK: - From
struct From: Codable {
    let day, month, year: Int?
}

// MARK: - Broadcast
struct Broadcast: Codable {
    let day, time, timezone, string: String?
}

// MARK: - Demographic
struct Demographic: Codable {
    let malID: Int?
    let type, name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

// MARK: - Images
struct Images: Codable {
    let jpg: Jpg?
}

// MARK: - Jpg
struct Jpg: Codable {
    let imageURL, largeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Title
struct Title: Codable {
    let type, title: String?
}

typealias Animes = [Anime]
