//
//  TagService.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import Foundation

final class TagService {
    
    init() {
        
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
