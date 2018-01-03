//
//  LastFM_API.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//  Copyright © 2018 Dmytro Golub. All rights reserved.
//

import Foundation


struct SearchMatches : Equatable {
    
    var albumName:String?
    var artist:String?
    var song:String?
    var url:String?
    var imageURL:String?
    var mbid:String?
    var mode:SearchCondition
    
    init(_ dict:NSDictionary,_ condition:SearchCondition) {
        
        mode = condition
        
        if let album = dict["name"] as? String {
            albumName = album
        }
        
        if let artistName = dict["artist"] as? String {
            artist = artistName
        }
        
        if let albumURL = dict["url"] as? String {
            url = albumURL
        }
        
        if let infoID = dict["mbid"] as? String, infoID.count > 0 {
            mbid = infoID
        }
        
        if let imgURLs = dict["image"] as? NSArray {
            if let mediumImageURL = imgURLs[1] as? NSDictionary {
                imageURL = mediumImageURL["#text"] as? String
            }
        }
    }
    
    static func ==(lhs: SearchMatches, rhs: SearchMatches) -> Bool {
        return lhs.albumName == rhs.albumName && lhs.artist == rhs.artist && lhs.song == rhs.song
    }
    
}

struct MatchInfo {
    var imageURL:String?
    var info:String?
}

typealias ResultBlock = ([SearchMatches],Error?) -> Void
typealias SearchInfoResultBlock = (MatchInfo?,Error?) -> Void


protocol SearchArtist {
    func search(mode:SearchCondition,artist:String,result:@escaping ResultBlock)
}

protocol SearchInfo {
    func info(match:SearchMatches,result:@escaping SearchInfoResultBlock)
}

class LastFM_API : SearchArtist,SearchInfo {

    let apiKey:String
    let apiSecret:String
    let session:URLSession
    
    init(_ key:String, secret:String) {
        apiKey = key
        apiSecret = secret
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func info(match: SearchMatches, result: @escaping SearchInfoResultBlock) {
        let task = session.dataTask(with: self.buildRequest(getInfoQueryStr(match))) { [weak self] (data, response, error) in
            if let error = error {
                result(nil,error)
            }
            
            if let data = data {
                result(self?.parseInfoData(data, mode: match.mode), nil)
            }
        }
        task.resume()
    }
    
    func search(mode:SearchCondition,artist:String,result:@escaping ResultBlock) {
        let task = session.dataTask(with: self.buildRequest(searchQueryStr(mode, searchText: artist))) { [weak self] (data, response, error) in
            
            if let error = error {
                result([],error)
            }
            
            if let data = data {
                if let array = self?.parseData(data, mode: mode) {
                    if array.count > 0 {
                        result(array,nil)
                    } else {
                        result([],NSError(domain: "json error", code: 100, userInfo: nil))
                    }
                }
            } else {
                result([],NSError(domain: "json error", code: 100, userInfo: nil))
            }
        }
        task.resume()
    }
    
    func method(searchCondition:SearchCondition) -> String {
        var method = ""
        switch searchCondition {
        case .artist:
            method =  "artist"
        case .album:
            method =  "album"
        case .song:
            method = "track"
        }
        return method
    }
    
    func lastFMBaseURL() -> String {
        return "https://ws.audioscrobbler.com/2.0/?&api_key=\(self.apiKey)&format=json"
    }
    
    func searchQueryStr(_ condition:SearchCondition, searchText:String) -> String {
        let method = self.method(searchCondition: condition)
         return "method=\(method).search&\(method)=\(searchText)"
    }

    func getInfoQueryStr(_ match:SearchMatches) -> String {
        let method = self.method(searchCondition: match.mode)
        return "method=\(method).getinfo&mbid=\(match.mbid!)"
    }
    
    func buildRequest(_ query:String) -> URLRequest {
        let strURL = lastFMBaseURL() + "&" + query
        print(strURL)
        return URLRequest(url: URL(string: strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
    }
}

extension LastFM_API {
    func parseData(_ data:Data?, mode:SearchCondition) -> [SearchMatches] {
        if let data = data {
            if let dict = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! NSDictionary {
                if let results = dict["results"] as? NSDictionary {
                    let resultKey = "\(self.method(searchCondition: mode))matches"
                    if let albums = results[resultKey] as? NSDictionary {
                        return self.populateSearchResults(albums, mode: mode)
                    }
                }
                return []
            }
        }
        return []
    }
    
    func parseImage(_ results:NSDictionary) -> String? {
        var imageURL:String?
        if let images = results["image"] as? NSArray {
            
            if let large = images[3] as? NSDictionary {
                imageURL = large["#text"] as? String
            }
        }
        return imageURL
    }
    
    func parseInfoData(_ data:Data?, mode:SearchCondition) -> MatchInfo? {
        if let data = data {
            if let dict = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as! NSDictionary {
                
                let method = self.method(searchCondition: mode)
                
                if let results = dict[method] as? NSDictionary {
                    
                    var info = ""
                    let imageURL = (mode == .song ) ? parseImage((results["album"] as? NSDictionary)!) : parseImage(results)
                    
                    let key = (mode == .artist) ? "bio" : "wiki"
                    if let biography = results[key] as? NSDictionary {
                        if let summary = biography["summary"] as? String {
                            info = summary
                        }
                    }
                    
                    return MatchInfo(imageURL: imageURL, info: info)
                }
                return nil
            }
        }
        return nil
    }
    
    func populateSearchResults(_ dict:NSDictionary, mode:SearchCondition) ->   [SearchMatches] {
        var resultedArray = [SearchMatches]()
        let key = "\(self.method(searchCondition: mode))"
        if let albums = dict[key] {
            if let albums = albums as? NSArray {
                for item in albums {
                    if let item = item as? NSDictionary {
                        let s = SearchMatches(item,mode)
                        resultedArray.append(s)
                    }
                }
            }
        }
        return resultedArray
    }
}

extension LastFM_API {
    func loadSample() -> Data? {
        if let path = Bundle.main.url(forResource: "albums", withExtension: "json") {
            return try? Data(contentsOf: path)
        }
        return nil
    }
}
