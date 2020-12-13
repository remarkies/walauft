//
//  DataViewModel.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import Foundation
import Combine

final class DataViewModel: ObservableObject {

    var loadedRegion: RegionModel?
    
    @Published var data: [RegionDayModel]
    
    @Published var loading: Bool
    @Published var datesAvailable: [Date]
    @Published var filterTags: [TagModel]

    init() {
        self.data = []
        self.filterTags = []
        self.loading = false
        self.datesAvailable = []
    }
    
    func reset() {
        self.data = []
        self.filterTags = []
        self.datesAvailable = []
        self.loading = false
    }

    func reloadEvents(region: RegionModel) {
        self.loadedRegion = region
        self.data = []
        self.loading = true
        ApiService.loadEventsAsync(region: region, filters: filterTags) {
            (result) in
            if result != nil {
                self.data = result!
                self.datesAvailable = self.data.map { event in event.date }
                self.loading = false
            }
        }
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
    
    func addFilterTag(tag: TagModel) -> Bool {
        if !isFilterTag(tag: tag) {
            self.filterTags.append(tag)
            return true
        } else {
            return false
        }
    }
    
    func removeFilterTag(tag: TagModel) -> Bool {
        if isFilterTag(tag: tag) {
            if let index = self.filterTags.firstIndex(where: { $0 == tag }) {
                self.filterTags.remove(at: index)
                return true
            }
        }
        return false
    }
}
