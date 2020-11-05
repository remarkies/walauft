//
//  FilterService.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import Foundation

final class FilterService {
    
    init() {
        
    }
    
    func filterEventsWithTagsAsync(data: [RegionDayModel], filterTags: [TagModel],  completion: @escaping ([RegionDayModel]?) -> Void) {
        completion(data)
    }
    
}
