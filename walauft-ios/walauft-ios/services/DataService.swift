//
//  DataService.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import Foundation
import Combine

final class DataService : ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    var selectedRegion: RegionModel
    
    @Published var data: [RegionDayModel] {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var filterTags: [TagModel] {
        willSet {
            objectWillChange.send()
        }
        didSet {
            print(filterTags)
            EventService.loadEventsAsync(region: self.selectedRegion, filters: filterTags) {
                (result) in
                if result != nil {
                    self.data = result!
                }
                print("INFO: Loaded events for \(self.selectedRegion.name)")
            }
        }
    }
    
    init(selectedRegion: RegionModel) {
        self.selectedRegion = selectedRegion
        self.data = []
        self.filterTags = []
    }
    
    func isFilterTag(tag: TagModel) -> Bool {
        var isFilterTag = false
        
        for filterTag in filterTags {
            if tag == filterTag {
                isFilterTag = true
                break
            }
        }
        
        return isFilterTag
    }
    
    func loadTagsForSearchTextAsync(data: [RegionDayModel], searchText: String,  completion: @escaping ([TagModel]?) -> Void) {
        var foundTags: [TagModel] = []
        
        for model in data {
            for event in model.events {
                for tag in event.tags {
                    if tag.text.uppercased().contains(searchText.uppercased()) {
                        
                        if !foundTags.contains(where: { $0 == tag}) {
                            foundTags.append(tag)
                        }
                    }
                }
            }
        }
        
        completion(foundTags)
    }
}
