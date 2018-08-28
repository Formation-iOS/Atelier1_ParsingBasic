//
//  Movie.swift
//  Atelier1_Parsing
//
//  Created by CedricSoubrie on 12/10/2017.
//  Copyright © 2017 CedricSoubrie. All rights reserved.
//

import UIKit

class Movie: NSObject {
    var title: String = ""
    var overview: String = ""
    var voteAverage: Double = 0.0
    var releaseDate : Date = Date() // The movie DB format : "2017-09-05"
    
    init (json : JSON) {
        if let title = json["title"] as? String {
            self.title = title
        }
        if let overview = json["overview"] as? String {
            self.overview = overview
        }
        if let voteAverage = json["vote_average"] as? Double {
            self.voteAverage = voteAverage
        }
        
        // Get the date
        if let dateString = json["release_date"] as? String {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            dateFormater.timeZone = TimeZone(identifier: "GMT")
            if let releaseDate = dateFormater.date(from: dateString) {
                self.releaseDate = releaseDate
            }
        }
    }
    
    override var description: String {
        return "\(title) - (\(voteAverage)/10) - \(releaseDate) - \(overview)"
    }
    
    static func movieList () -> [Movie] {
        let jsonMovies = FileManager.jsonArray(fromJSONFile: "BestMovie")
        
        var movies = [Movie]()
        for jsonPart in jsonMovies {
            let movie = Movie(json: jsonPart)
            movies.append(movie)
        }
        return movies
    }
}

