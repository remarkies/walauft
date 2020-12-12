//
//  ApiService.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

final class ApiService: ObservableObject {
    
    static let useLocalEnvironement = false
    static let apiPath: String = "https://api.walauft.ch/"
    static let devApiPath: String = "http://localhost:3000/"
    static let eventsPath: String = "events/"
    static let tagsPath: String = "tags/"
    
    init() {
        
    }
    
    static func loadEventsAsync(region: RegionModel, filters: [TagModel], completion: @escaping ([RegionDayModel]?) -> Void) {
        
        let filter = FilterModel(regionId: region.id, tags: filters)
        
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
                var model:[RegionDayModel] = []
                do {
                    model = try JSONDecoder().decode([RegionDayModel].self, from: data)
                    
                } catch let error {
                    print("\(data)")
                    print("JSONDecoder failed, \(error)")
                }
                
                DispatchQueue.main.async {
                    completion(model)
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
                var model:[TagModel] = []
                do {
                    model = try JSONDecoder().decode([TagModel].self, from: data)
                    
                } catch let error {
                    print("\(data)")
                    print("JSONDecoder failed, \(error)")
                }
                DispatchQueue.main.async {
                    completion(model)
                }
            }
        }).resume()
    }
}
