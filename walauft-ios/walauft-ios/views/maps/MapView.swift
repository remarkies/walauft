//
//  MapView.swift
//  walauft-ios
//
//  Created by dariush mehdiaraghi on 04.12.20.
//
import UIKit
import SwiftUI

struct MapView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> MapsViewController {
            let mapsview = MapsViewController()
           
            return mapsview
       }
       
       // 3.
       func updateUIViewController(_ uiViewController: MapsViewController, context: Context) {
           
       }
    
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
