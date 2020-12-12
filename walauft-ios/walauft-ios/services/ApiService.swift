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
        
        let tags: [ApiTagModel] = []
        
        
        let filter = FilterModel(regionId: region.id, tags: tags)
        
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
                var apiModels: [ApiRegionDayModel] = []
                do {
                    apiModels = try JSONDecoder().decode([ApiRegionDayModel].self, from: data)
                } catch let error {
                    print("\(data)")
                    print("JSONDecoder failed, \(error)")
                }
                
                var regionDays: [RegionDayModel] = []
                
                for apiModel in apiModels {
                    
                    var events: [EventModel] = []
                    for apiEvent in apiModel.events {
                        
                        var tags: [TagModel] = []
                        for apiTag in apiEvent.tags {
                            let tag = TagModel(type: TagOption(rawValue: apiTag.type) ?? .unknown, text: apiTag.text)
                            tags.append(tag)
                        }
                        
                        let location = LocationModel(name: apiEvent.location!.name, street: apiEvent.location!.street, streetNo: apiEvent.location!.streetno, zipCode: apiEvent.location!.zipcode, city: apiEvent.location!.city, longitude: apiEvent.location!.longitude, latitude: apiEvent.location!.latitude)
                        
                        let event = EventModel(name: apiEvent.name, date: apiEvent.date, time: apiEvent.start, tags: tags, minage: apiEvent.minage, price: apiEvent.price, description: apiEvent.text, location: location)
                        
                        events.append(event)
                    }
                    
                    let regionDay = RegionDayModel(date: apiModel.date, region: region, events: events)
                    regionDays.append(regionDay)
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
                var apiModels: [ApiTagModel] = []
                do {
                    apiModels = try JSONDecoder().decode([ApiTagModel].self, from: data)
                } catch let error {
                    print("\(data)")
                    print("JSONDecoder failed, \(error)")
                }
                
                var tags: [TagModel] = []
                for apiTag in apiModels {
                    let tag = TagModel(type: TagOption(rawValue: apiTag.type) ?? .unknown, text: apiTag.text)
                    tags.append(tag)
                }
                
                DispatchQueue.main.async {
                    completion(tags)
                }
            }
        }).resume()
    }
}
