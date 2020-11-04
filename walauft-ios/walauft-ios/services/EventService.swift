//
//  EventService.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

final class EventService: ObservableObject {
    
    let apiPath: String = "https://api.walauft.ch/events/"
    
    init() {
        
    }
    
    func loadEventsAsync(region: RegionModel, completion: @escaping ([RegionDayModel]?) -> Void) {
        
        let url = URL(string: "\(apiPath)\(String(region.id))")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
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
                        let model = try JSONDecoder().decode([RegionDayModel].self, from: data)
                        completion(model)
                    } catch let error {
                        print("JSONDecoder failed, \(error)")
                    }
                }
            }
        }).resume()
    }
}
