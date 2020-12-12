//
//  DataService.swift
//  walauft-ios
//
//  Created by Luka Kramer on 05.11.20.
//

import Foundation
import Combine

final class DataService: ObservableObject {

    var selectedRegion: RegionModel

    @Published var loading: Bool
    @Published var datesAvailable: [Date]
    @Published var data: [RegionDayModel] {
        willSet {
            datesAvailable = self.data.map{event in event.date}
            objectWillChange.send()
        }
    }

    @Published var filterTags: [TagModel] {
        didSet {
            reloadEvents()
        }
    }

    init(selectedRegion: RegionModel) {
        self.selectedRegion = selectedRegion
        self.data = []
        self.filterTags = []
        self.loading = false
        self.datesAvailable = []
    }

    func reloadEvents() {
        self.data = []
        self.loading = true
        ApiService.loadEventsAsync(region: self.selectedRegion, filters: filterTags) {
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
