//
//  RegionDayListView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 25.11.20.
//

import SwiftUI

struct RegionDayListView: View {
    
    func getGermanDate(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "dd. MMMM"
        return formatter.string(from: date)
    }
    
    @EnvironmentObject var dataService : DataService
    @Binding var days: [RegionDayModel]
    
    var body: some View {
        
        if dataService.loading {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                   LoadingView()
                    .padding(.top, -100)
                    .transition(.opacity)
                    
                    Spacer()
                }
                Spacer()
            }
            
        } else if days.count > 0 {
            List {
                ForEach(days) {
                day in
                    Section (header: GroupHeaderView(text: "\(getGermanDate(date: day.date))")) {
                        RegionDayRowView(regionDay: day)
                            .listRowBackground(Color("Background"))
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .background(Color("Background"))
            .listStyle(GroupedListStyle())
            .onAppear {

                // this will disable highlighting the cell when is selected
                UITableViewCell.appearance().selectionStyle = .none

                // you can also remove the row separators
                UITableView.appearance().separatorStyle = .none

            }
        } else {
            VStack {
                HStack {
                    Spacer()
                    
                    NoEventsFoundView()
                        .padding()
                    
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct RegionDayListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{}
    }
}
