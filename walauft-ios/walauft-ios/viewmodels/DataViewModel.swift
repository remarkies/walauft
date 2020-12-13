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

    @Published var loading: Bool
    @Published var datesAvailable: [Date]
    @Published var data: [RegionDayModel] {
        willSet {
            datesAvailable = self.data.map { event in event.date }
        }
    }

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
                self.datesAvailable = self.data.map{event in event.date}
                self.loading = false
            }
        }
    }

    func isFilterTag(tag: TagModel) -> Bool {
        var isFilterTag = false

        for filterTag in filterTags {
            if tag.text == filterTag.text && tag.type == filterTag.type {
                isFilterTag = true
                break
            }
        }

        return isFilterTag
    }
}
