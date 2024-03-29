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
    
    @EnvironmentObject var dataViewModel : DataViewModel
    @EnvironmentObject var selectedRegion: RegionModel
    @Binding var selectedDate: Int
    private var event: EventModel?
    private var eventsClickable: Bool
    
    init(selectedDate: Binding<Int>? = Binding.constant(0),event: EventModel? = nil, eventsClickable: Bool) {
        self._selectedDate = selectedDate ?? Binding.constant(0)
        self.event = event
        self.eventsClickable = eventsClickable

    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.overrideUserInterfaceStyle = .dark
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
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
        if (!dataViewModel.data.isEmpty && dataViewModel.data.indices.contains(selectedDate)){
            let annotationsOfLocations = getAnnotationsFromEvents(events: dataViewModel.data[selectedDate].events)
            mapView.addAnnotations(annotationsOfLocations)
            mapView.showAnnotations(annotationsOfLocations, animated: true)
        }

        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations.filter{annotation in
            !(annotation is MKUserLocation)
        })
        if (!dataViewModel.data.isEmpty && dataViewModel.data.indices.contains(selectedDate)){
            let annotationsOfEvents = getAnnotationsFromEvents(events: dataViewModel.data[selectedDate].events)
            mapView.addAnnotations(annotationsOfEvents.filter{annotation in
                !(annotation is MKUserLocation)
            }
            )
            mapView.showAnnotations(annotationsOfEvents, animated: true)
        }
        
    }

    private func getAnnotationsFromEvents(events: [EventModel])->[MKAnnotation]{
        let locations: [(LocationModel, String)]
        //        let eventsWithNoCoordinates = events.filter{ event in event.location!.latitude == nil}
        if event == nil{
            let eventsWithALocation = events.filter{ event in event.location.latitude != nil}
            locations = eventsWithALocation.map { event in (event.location, event.name) }
        }
        else{
            locations = [(event!.location, event!.name)]
        }
        let annotationsOfLocations =  locations.map {
            (location, eventName)-> MKPointAnnotation in
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
            annotation.title = location.name
            //dont need this: annotation.subtitle = eventName
            return annotation
        }
        
        return annotationsOfLocations
    }
    
    final class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapViewRep
        init(_ parent: MapViewRep) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if (parent.eventsClickable && !(view.annotation is MKUserLocation)){
                let eventClicked = parent.dataViewModel.data[parent.selectedDate].events.filter {
                    event in
                    
                    event.location.name == view.annotation?.title
                }
                let detailView = UIHostingController(rootView: DetailView(selectedEvent: eventClicked[0]).environmentObject(parent.selectedRegion).environmentObject(parent.dataViewModel))
                
                mapView.parentViewController?.navigationController?.pushViewController(detailView, animated: true)
            }
        }
        
        // to deactivate decluttering of annotations
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let reuseIdentifier = "annotationView"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            if annotation is MKUserLocation {
                // Annotation of users location
                return view
            }
            else{
                if #available(iOS 11.0, *) {
                    if view == nil {
                        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
                    }
                    view?.displayPriority = .required
                } else {
                    if view == nil {
                        
                        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
                    }
                }
                view?.annotation = annotation
                view?.canShowCallout = false
                
                return view
            }
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
