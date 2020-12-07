//
//  FilterService.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import Foundation
import Combine

final class FilterService : ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    var data: [RegionDayModel] {
        willSet {
            objectWillChange.send()
        }
        didSet {
            filterEventsWithTagsAsync(data: data, filterTags: filterTags, completion: {
                newData in
                self.filteredData = newData!
            })
        }
    }
    
    @Published var filterTags: [TagModel] {
        willSet {
            objectWillChange.send()
        }
        didSet {
            
            filterEventsWithTagsAsync(data: deactivateTags(days: data), filterTags: filterTags, completion: {
                newData in
                self.filteredData = newData!
            })
        }
    }
    
    @Published var filteredData: [RegionDayModel] {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        data = []
        filterTags = []
        filteredData = []
    }
    
    func deactivateTags(days: [RegionDayModel]) -> [RegionDayModel] {
        for d in days {
            for e in d.events {
                for t in e.tags {
                    t.isSelected = false
                }
            }
        }
        
        return days
    }
    func activateTags(event: EventModel, tags: [TagModel]) -> Void {
        for t in event.tags {
            for ft in tags {
                if t == ft {
                    t.isSelected = true
                }
            }
        }
    }
    
    func hasEventTag(event: EventModel, tag: TagModel) -> Bool {
        var hasTag = false
        
        for t in event.tags {
            if tag == t {
                hasTag = true
            }
        }
        
        return hasTag
    }
    
    func meetsEventRequirements(event: EventModel, tags: [TagModel]) -> Bool {
        var meetsRequirement = false
        
        for tag in tags {
            if hasEventTag(event: event, tag: tag) {
                meetsRequirement = true
            }
        }
        
        return meetsRequirement
    }
    
    func filterEventsWithTagsAsync(data: [RegionDayModel], filterTags: [TagModel],  completion: @escaping ([RegionDayModel]?) -> Void) {
        
        var days: [RegionDayModel] = []
        
        if(filterTags.count > 0) {
            for day in data {
                var eventsShown: [EventModel] = []
                for event in day.events {
                    
                    //deactivateTags(event: event)
                    
                    if meetsEventRequirements(event: event, tags: filterTags) {
                        activateTags(event: event, tags: filterTags)
                        eventsShown.append(event)
                    }
                    
                    
                    
                }
                
                if eventsShown.count > 0 {
                    let newDay = RegionDayModel(_id: day._id, date: day.date, region: day.region, events: eventsShown)
                    days.append(newDay)
                }
            }
        } else {
            days = data
        }
        completion(days)
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
