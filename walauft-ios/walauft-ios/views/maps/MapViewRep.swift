//
//  MapsViewRep.swift
//  walauft-ios
//
//  Created by dariush mehdiaraghi on 05.12.20.
//
//  Rewritten the ViewController as a UIViewRepesentable from the example shown here: https://github.com/fmo91/MapKitGoogleStyler

import SwiftUI
import MapKit
import MapKitGoogleStyler

struct MapViewRep: UIViewRepresentable {
 
    var events: [EventModel]
    var evetsClickable: Bool
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)

        guard let overlayFileURLString = Bundle.main.path(forResource: "overlay", ofType: "json") else {
                print("could not load JSON")
                return MKMapView(frame: .zero)
        }
        let overlayFileURL = URL(fileURLWithPath: overlayFileURLString)
        guard let tileOverlay = try? MapKitGoogleStyler.buildOverlay(with: overlayFileURL) else {
            print("could not load tiles")
            return MKMapView(frame: .zero)
        }
        mapView.addOverlay(tileOverlay)
        let eventsWithALocation = events.filter{ event in event.location!.latitude != nil}
        let locations = eventsWithALocation.map { event in event.location! }

        let annotationsOfLocations =  locations.map {
        location -> MKPointAnnotation in
         
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
            annotation.title = location.name
            
            return annotation
        }
        mapView.addAnnotations(annotationsOfLocations)
        mapView.showAnnotations(annotationsOfLocations, animated: true)
     
        mapView.overrideUserInterfaceStyle = .dark

        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {

    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapViewRep
        init(_ parent: MapViewRep) {
            self.parent = parent
        }
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if (parent.evetsClickable){
                let eventClicked = parent.events.filter{
                     event in
                     event.location!.name == view.annotation?.title
                 }
                let detailView = UIHostingController(rootView: DetailView(selectedEvent: eventClicked[0]))
                              
               
                mapView.parentViewController?.navigationController?.pushViewController(detailView, animated: true)
            }
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationReuseId = "Place"
            var anView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationReuseId)
              if anView == nil {
                  anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
              } else {
                  anView!.annotation = annotation
              }
 
            anView!.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            anView!.image =  UIImage(systemName: "music.house")
            anView!.largeContentTitle = annotation.title!
            anView!.backgroundColor = UIColor.white
              anView!.canShowCallout = false
              return anView
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let tileOverlay = overlay as? MKTileOverlay {
                return MKTileOverlayRenderer(tileOverlay: tileOverlay)
            } else {
                return MKOverlayRenderer(overlay: overlay)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
