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
    
    var filterTags: [TagModel] {
        willSet {
            objectWillChange.send()
        }
    }
    init() {
        filterTags = [];
    }
    
    func filterEventsWithTagsAsync(data: [RegionDayModel], filterTags: [TagModel],  completion: @escaping ([RegionDayModel]?) -> Void) {
        completion(data)
    }
    
}
