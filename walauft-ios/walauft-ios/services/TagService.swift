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
                    if tag.text.contains(searchText) {
                        
                        if !foundTags.contains(where: { $0.text == tag.text && $0.type == tag.type}) {
                            foundTags.append(tag)
                        }
                    }
                }
            }
        }
        
        completion(foundTags)
    }
    
}
