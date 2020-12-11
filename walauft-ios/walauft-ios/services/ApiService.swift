//
//  ApiService.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

final class ApiService: ObservableObject {
    
    static let apiPath: String = "https://api.walauft.ch/"
    static let devApiPath: String = "http://localhost:3000/"
    static let eventsPath: String = "events/"
    static let tagsPath: String = "tags/"
    
    init() {
        
    }
    
    static func loadEventsAsync(region: RegionModel, filters: [TagModel], completion: @escaping ([RegionDayModel]?) -> Void) {
        
        let filter = FilterModel(regionId: region.id, tags: filters)
        
        let url = URL(string: "\(apiPath)\(eventsPath)")!
        
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
                DispatchQueue.main.async {
                    do {
                        //let model2 = try JSONDecoder().decode(RegionDayModel.self, from: data)
                        let model = try JSONDecoder().decode([RegionDayModel].self, from: data)
                        completion(model)
                    } catch let error {
                        print("\(data)")
                        print("JSONDecoder failed, \(error)")
                    }
                }
            }
        }).resume()
    }
    static func loadProposedTagsAsync(selectedRegion: RegionModel, search: String, completion: @escaping ([TagModel]?) -> Void) {
        
        let model = SearchModel(regionId: selectedRegion.id, search: search)
        
        let url = URL(string: "\(apiPath)\(tagsPath)")!
        
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
                DispatchQueue.main.async {
                    do {
                        let model = try JSONDecoder().decode([TagModel].self, from: data)
                        completion(model)
                    } catch let error {
                        print("\(data)")
                        print("JSONDecoder failed, \(error)")
                    }
                }
            }
        }).resume()
    }
}
