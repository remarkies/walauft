//
//  ApiService.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

final class ApiService: ObservableObject {
    
    static let useLocalEnvironement = true
    static let apiPath: String = "https://api.walauft.ch/"
    static let devApiPath: String = "http://localhost:3000/"
    static let eventsPath: String = "events/"
    static let tagsPath: String = "tags/"
    
    init() {
        
    }
    
    static func loadEventsAsync(region: RegionModel, filters: [TagModel], completion: @escaping ([RegionDayModel]?) -> Void) {

        var searchTags: [SearchTagModel] = []
        for filterItem in filters {
            searchTags.append(SearchTagModel(type: filterItem.type.rawValue, text: filterItem.text))
        }
        
        let filter = FilterModel(regionId: region.id, tags: searchTags)
        
        var url = URL(string: "\(apiPath)\(eventsPath)")!
        if useLocalEnvironement {
            url = URL(string: "\(devApiPath)\(eventsPath)")!
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // encode post struct into JSON format
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(filter)
            request.httpBody = jsonData
        } catch {
            print(String(describing: error))
        }
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    print("Loading events for \(region.name) failed, \(error)")
                    completion(nil)
                }
                return
                
            }
            else if let data = data {
                var regionDays: [RegionDayModel] = []
                do {
                    regionDays = try JSONDecoder().decode([RegionDayModel].self, from: data)
                } catch let error {
                    print("\(data)")
                    print("JSONDecoder failed, \(error)")
                }
                
                DispatchQueue.main.async {
                    completion(regionDays)
                }
            }
        }).resume()
    }
    
    static func loadProposedTagsAsync(selectedRegion: RegionModel, search: String, completion: @escaping ([TagModel]?) -> Void) {
        
        let model = SearchModel(regionId: selectedRegion.id, search: search)
        
        var url = URL(string: "\(apiPath)\(tagsPath)")!
        
        if useLocalEnvironement {
            url = URL(string: "\(devApiPath)\(tagsPath)")!
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // encode post struct into JSON format
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(model)
            request.httpBody = jsonData
        } catch {
            print(String(describing: error))
        }
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    print("Loading tags for \(search) failed, \(error)")
                    completion(nil)
                }
                return
            }
            else if let data = data {
                var tags: [TagModel] = []
                do {
                    tags = try JSONDecoder().decode([TagModel].self, from: data)
                } catch let error {
                    print("\(data)")
                    print("JSONDecoder failed, \(error)")
                }
                
                DispatchQueue.main.async {
                    completion(tags)
                }
            }
        }).resume()
    }
}
