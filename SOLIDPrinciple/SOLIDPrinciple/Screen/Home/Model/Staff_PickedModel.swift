//
//  Staff_picked.swift
//  SOLIDPrinciple
//
//  Created by Chandan on 14/01/23.
//

import Foundation
// MARK: - WelcomeElement
struct Staff_PickedModel: Codable {
    var rating : Double?
    var id : Int?
    var revenue : Int?
    var releaseDate : String?
    var director : Director?
    var posterUrl : String?
    var cast : [Cast]?
    var runtime : Int?
    var title : String?
    var overview : String?
    var reviews : Int?
    var budget : Int?
    var language : String?
    var genres : [String]?
    var bookmark : Bool?

    enum CodingKeys: String, CodingKey {

        case rating = "rating"
        case id = "id"
        case revenue = "revenue"
        case releaseDate = "releaseDate"
        case director = "director"
        case posterUrl = "posterUrl"
        case cast = "cast"
        case runtime = "runtime"
        case title = "title"
        case overview = "overview"
        case reviews = "reviews"
        case budget = "budget"
        case language = "language"
        case genres = "genres"
        case bookmark = "bookmark"
    }
    /*
     init(from decoder: Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         rating = try values.decodeIfPresent(Double.self, forKey: .rating)
         id = try values.decodeIfPresent(Int.self, forKey: .id)
         revenue = try values.decodeIfPresent(Int.self, forKey: .revenue)
         releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
         director = try values.decodeIfPresent(Director.self, forKey: .director)
         posterUrl = try values.decodeIfPresent(String.self, forKey: .posterUrl)
         cast = try values.decodeIfPresent([Cast].self, forKey: .cast)
         runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
         title = try values.decodeIfPresent(String.self, forKey: .title)
         overview = try values.decodeIfPresent(String.self, forKey: .overview)
         reviews = try values.decodeIfPresent(Int.self, forKey: .reviews)
         budget = try values.decodeIfPresent(Int.self, forKey: .budget)
         language = try values.decodeIfPresent(String.self, forKey: .language)
         genres = try values.decodeIfPresent([String].self, forKey: .genres)
     }
     */
}

// MARK: - Cast
struct Cast: Codable {
    let name : String?
    let pictureUrl : String?
    let character : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case pictureUrl = "pictureUrl"
        case character = "character"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        pictureUrl = try values.decodeIfPresent(String.self, forKey: .pictureUrl)
        character = try values.decodeIfPresent(String.self, forKey: .character)
    }
}

// MARK: - Director
struct Director: Codable {
    let name : String?
    let pictureUrl : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case pictureUrl = "pictureUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        pictureUrl = try values.decodeIfPresent(String.self, forKey: .pictureUrl)
    }
}
typealias Welcome = [Staff_PickedModel]
