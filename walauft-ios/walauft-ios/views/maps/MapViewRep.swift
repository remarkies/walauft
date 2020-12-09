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
    
    @EnvironmentObject var dataService : DataService
    @EnvironmentObject var selectedRegion: RegionModel
    @Binding var selectedDate: Int
    private  var event: EventModel?
    private var eventsClickable: Bool
    
    init(selectedDate: Binding<Int>? = Binding.constant(0),event: EventModel? = nil, eventsClickable: Bool) {
        self._selectedDate = selectedDate ?? Binding.constant(0)
        self.event = event
        self.eventsClickable = eventsClickable
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        let nameOfJSON = String(selectedRegion.id)  
        guard let overlayFileURLString = Bundle.main.path(forResource: nameOfJSON, ofType: "json") else {
                print("could not load JSON")
                return MKMapView(frame: .zero)
        }
        let overlayFileURL = URL(fileURLWithPath: overlayFileURLString)
        guard let tileOverlay = try? MapKitGoogleStyler.buildOverlay(with: overlayFileURL) else {
            print("could not load tiles")
            return MKMapView(frame: .zero)
        }
        mapView.addOverlay(tileOverlay)
        if (!dataService.data.isEmpty){
            let annotationsOfLocations = getAnnotationsFromEvents(events: dataService.data[selectedDate].events)
            mapView.addAnnotations(annotationsOfLocations)
            mapView.showAnnotations(annotationsOfLocations, animated: true)
        }
        mapView.overrideUserInterfaceStyle = .dark
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        if (!dataService.data.isEmpty){
            let annotationsOfEvents = getAnnotationsFromEvents(events: dataService.data[selectedDate].events)
            mapView.addAnnotations(annotationsOfEvents)
            mapView.showAnnotations(annotationsOfEvents, animated: true)
        }
    }

    private func getAnnotationsFromEvents(events: [EventModel])->[MKAnnotation]{
        let locations: [LocationModel]
        if event == nil{
            let eventsWithALocation = events.filter{ event in event.location!.latitude != nil}
            var eventsWithNoLocation = events.filter{ event in event.location!.latitude == nil}
//            eventsWithNoLocation.map{ event in
//                MapService.searchCoordinates(forAddress: "\(event.location!.street) \(event.location!.streetno), \(event.location!.zipcode), \(event.location!.city)") {
//                    coordinate in
//                    if coordinate != nil {
//                        return coordinate!.latitude
//
//                        }
//
//                    }
//                }
            
    
           
            locations = eventsWithALocation.map { event in event.location! }
        }
        else{
             locations = [event!.location!]
        }
        let annotationsOfLocations =  locations.map {
        location -> MKPointAnnotation in

            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
            annotation.title = location.name

            return annotation
        }
        return annotationsOfLocations
    }

    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapViewRep
        init(_ parent: MapViewRep) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if (parent.eventsClickable){
                let eventClicked = parent.dataService.data[parent.selectedDate].events.filter {
                     event in

                     event.location!.name == view.annotation?.title
                 }

                let detailView = UIHostingController(rootView: DetailView(selectedEvent: eventClicked[0]).environmentObject(parent.selectedRegion).environmentObject(parent.dataService))
                

                mapView.parentViewController?.navigationController?.pushViewController(detailView, animated: true)
            }
        }
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            let annotationReuseId = "Place"
//            var anView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationReuseId)
//              if anView == nil {
//                  anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
//              } else {
//                  anView!.annotation = annotation
//              }
//
//           // anView!.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//            anView!.image =  UIImage(systemName: "music.house")
//            anView!.largeContentTitle = annotation.title!
//            anView!.backgroundColor = UIColor.white
//              anView!.canShowCallout = false
//              return anView
//        }
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
