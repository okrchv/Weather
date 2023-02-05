//
//  SearchLocationView.swift
//  Weather
//
//  Created by Oleh Kiurchev on 30.01.2023.
//

import SwiftUI
import Combine
import CoreLocation
import MapKit
import OpenWeatherAPI

struct SearchLocationView: View {
    @EnvironmentObject var locationStorage: LocationStorage
    @Environment(\.dismiss) var dismiss

    @State private var locationSearchQuery: String = ""
    @State private var locationSearchResults: [LocationData] = []

    @State private var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    @State private var nearbyLocations: [LocationData] = []

    @State private var selectedLocationCoordinate: CLLocationCoordinate2D?

    let coordinateRegionPublisher = PassthroughSubject<MKCoordinateRegion, Never>()
    let locationSearchQueryPublisher = PassthroughSubject<String, Never>()

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(Font.custom("Helvetica", size: 22))
                        .foregroundColor(Color("White"))
                }
                TextField("Enter location", text: $locationSearchQuery)
                    .contentShape(Rectangle())
                    .submitLabel(.search)
                    .onSubmit {
                        onLocationNameSubmit()
                    }
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: locationSearchQuery, perform: locationSearchQueryPublisher.send)
                    .onReceive(
                        locationSearchQueryPublisher
                            .filter({ name in !name.isEmpty })
                            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                    ) { _ in
                        onLocationNameSubmit()
                    }

                Button {
                    onLocationNameSubmit()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(Font.custom("Helvetica", size: 22))
                        .foregroundColor(Color("White"))
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color("DarkBlue"))
            
            ZStack {
                Map(
                    coordinateRegion: $coordinateRegion,
                    annotationItems: nearbyLocations
                ) { location in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)) {
                        Button {
                            selectedLocationCoordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lon)
                            
                            if let coordinate = selectedLocationCoordinate {
                                locationStorage.store(coordinate)
                            }
                            
                            dismiss()
                        } label: {
                            HStack(spacing: 2) {
                                Image(systemName: "mappin.circle.fill")
                                Text(location.name)
                                    .allowsTightening(true)
                            }
                            .font(Font.custom("Helvetica", size: 16))
                            .foregroundColor(Color.red)
                        }
                    }
                }
                .onChange(of: coordinateRegion, perform: coordinateRegionPublisher.send)
                .onReceive(
                    coordinateRegionPublisher
                        .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                ) { coordinateRegion in
                    Task {
                        if let locations = await findNearbyLocations(coordinateRegion.center) {
                            nearbyLocations = locations
                        }
                    }
                }
                
                VStack(spacing: 0) {
                    ForEach(locationSearchResults, id: \.self) { location in
                        HStack {
                            Text("\(location.name), \(location.country)")
                        }
                        .frame(
                          minWidth: 0,
                          maxWidth: .infinity,
                          alignment: .topLeading
                        )
                        .padding(.leading, 45)
                        .padding(.trailing, 10)
                        .padding(.vertical, 5)
                        .contentShape(Rectangle())
                        .background(Color("White"))
                        .font(Font.custom("Helvetica", size: 20))
                        .onTapGesture {
                            let coordinate = CLLocationCoordinate2D(
                                latitude: location.lat,
                                longitude: location.lon
                            )
                            
                            selectedLocationCoordinate = coordinate

                            coordinateRegion.center = coordinate
                            locationSearchQuery = ""
                            locationSearchResults = []
                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            coordinateRegion.center = locationStorage.coordinate
        }
    }

    func onLocationNameSubmit() {
        guard locationSearchQuery.isEmpty == false else { return }

        Task {
            if let locations = await findCoordinates(locationSearchQuery) {
                locationSearchResults = locations
            }
        }
    }
    
    func findCoordinates(_ locationName: String) async -> [LocationData]? {
        let response = try? await OpenWeatherAPI.Client.shared?.send(
            OpenWeatherAPI.Paths.directGeocode(q: locationName, limit: 5)
        )

        return response?.value
    }
    
    func findNearbyLocations(_ coordinates: CLLocationCoordinate2D) async -> [LocationData]? {
        let response = try? await OpenWeatherAPI.Client.shared?.send(
            OpenWeatherAPI.Paths.reverseGeocode(lat: coordinates.latitude, lon: coordinates.longitude, limit: 5)
        )
    
        return response?.value
    }
}

//struct SearchLocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchLocationView()
//    }
//}


