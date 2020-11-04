//
//  TagService.swift
//  walauft-ios
//
//  Created by Luka Kramer on 04.11.20.
//

import Foundation

final class TagService {
    
    init() {
        
    }
    
    static func getTagsForEvent(event: EventModel) -> [TagModel] {
        var foundTags:[TagModel] = []
        
        foundTags.append(contentsOf: getTagsForStyles(styles: event.musicstyles))
        foundTags.append(contentsOf: getTagsForActs(acts: event.acts))
        foundTags.append(contentsOf: getTagsForLocation(location: event.location!.name))
        
        return foundTags
    }
    
    static func getTagsForStyles(styles: String) -> [TagModel] {
        var foundTags:[TagModel] = []
        
        let array = styles.components(separatedBy: ",").map {
            word in word.trimmingCharacters(in: .whitespaces)
        }
        
        array.forEach {
            if "\($0)".count > 0 {
                foundTags.append(TagModel(type: .style, text: "\($0)"))
            }
        }
    
        return foundTags
    }
    
    static func getTagsForActs(acts: String) -> [TagModel] {
        var foundTags:[TagModel] = []
        
        let array = acts.components(separatedBy: ",").map {
            word in word.trimmingCharacters(in: .whitespaces)
        }
        
        array.forEach {
            if "\($0)".count > 0 {
                foundTags.append(TagModel(type: .act, text: "\($0)"))
            }
            
        }
    
        return foundTags
    }
    
    static func getTagsForLocation(location: String) -> [TagModel] {
        var foundTags:[TagModel] = []
        if "\(location)".count > 0 {
            foundTags.append(TagModel(type: .location, text: location))
        }
        return foundTags
    }
}
