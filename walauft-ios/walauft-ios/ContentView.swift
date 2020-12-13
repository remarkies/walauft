//
//  ContentView.swift
//  walauft-ios
//
//  Created by Luka Kramer on 03.11.20.
//

import SwiftUI

struct ContentView: View {
    var dataViewModel = DataViewModel()
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        // this is not the same as manipulating the proxy directly
        let appearance = UINavigationBarAppearance()
        
        // this overrides everything you have set up earlier.
        appearance.configureWithTransparentBackground()
        
        guard let customFont = UIFont(name: "Manrope-Bold", size: 20) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        
        // this only applies to big titles
        appearance.largeTitleTextAttributes = [
            .font : UIFontMetrics.default.scaledFont(for: customFont),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        // this only applies to small titles
        appearance.titleTextAttributes = [
            .font : customFont,
            NSAttributedString.Key.foregroundColor : UIColor.white,
        ]
        
        
        //In the following two lines you make sure that you apply the style for good
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        // This property is not present on the UINavigationBarAppearance
        // object for some reason and you have to leave it til the end
        UINavigationBar.appearance().tintColor = .white

        
    }
    
    @State var selectedRegion: RegionModel?

    var body: some View {
            NavigationView {
                HomeView()
                    .environmentObject(dataViewModel)
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
