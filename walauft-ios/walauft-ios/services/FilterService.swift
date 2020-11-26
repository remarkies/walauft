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
    
    var filterTags: [TagModel] {
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
    
    var filteredData: [RegionDayModel] {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        data = []
        filterTags = []
        filteredData = []
    }
    
    func hasEventTag(event: EventModel, tag: TagModel) -> Bool {
        var hasTag = false
        
        for t in event.tags {
            if tag.text == t.text && tag.type == t.type {
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

                    if meetsEventRequirements(event: event, tags: filterTags) {
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
    
}
