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
    var vote_average: Float = 0.0
    var release_date : Date = Date() // The movie DB format : "2017-09-05"
    
    init (json : JSON) {
        self.title = json["title"] as! String
        self.overview = json["overview"] as! String
        self.vote_average = json["vote_average"] as! Float
        
        // Get the date
        let dateString = json["release_date"] as! String
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-mm-dd"
        self.release_date = dateFormater.date(from: dateString)!
    }
    
    override var description: String {
        return "\(title) - (\(vote_average)/10)"
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

