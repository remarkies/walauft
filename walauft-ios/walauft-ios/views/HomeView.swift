//
//  Home.swift
//  walauft-ios
//
//  Created by Luka Kramer on 03.11.20.
//

import SwiftUI

struct HomeView: View {
    
    @State var regions: [RegionModel] = [
        RegionModel(id: 2, name: "Lozärn"),
        RegionModel(id: 3, name: "Bärn"),
        RegionModel(id: 4, name: "Baasel"),
        RegionModel(id: 5, name: "St.Galle"),
        RegionModel(id: 6, name: "Züri")
    ]
    
    var body: some View {
        VStack (alignment: .leading)  {
            
            VStack (alignment: .leading) {
                HStack (alignment: .top) {
                    VStack {
                        Text("IN")
                        .bold()
                        .textCase(.uppercase)
                        .font(.system(size: 50))
                        .foregroundColor(Color("SubtleForeground"))
                        .padding(.horizontal, 16)
                        .padding(.top, 40)
                        
                        Spacer()
                    }
                        
                    HStack {
                        Spacer()
                        Text("Walauft")
                            .bold()
                            .textCase(.uppercase)
                            .font(.system(size: 60))
                            .foregroundColor(Color("SubtleForeground"))
                            .rotationEffect(.degrees(-90))
                            .padding(.horizontal, -100)
                            .padding(.top, 158)
                    }
                    
                }
                
                VStack  (alignment: .leading) {
                    ForEach(self.regions, id: \.self) {
                        region in
                        NavigationLink(destination: EventsView(selectedRegion: region)){
                            
                            HStack {
                                HStack {
                                    Text("\(region.name)")
                                        .bold()
                                        .textCase(.uppercase)
                                        .foregroundColor(Color("Foreground"))
                                    
                                    Spacer()
                                    Image(systemName: "arrow.right").font(.system(size: 16, weight: .bold))
                                        .foregroundColor(Color("SubtleForeground"))
                                }
                                
                                .padding(16)
                                
                            }
                            .border(Color("Layer1"), width: 2)
                            .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.bottom, 50)
            }
            
        }
        .background(Color("Background"))
        .ignoresSafeArea()
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
