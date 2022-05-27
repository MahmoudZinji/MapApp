//
//  LocationsViews.swift
//  MapApp
//
//  Created by Mahmoud Zinji on 2022-05-16.
//

import SwiftUI
import MapKit

struct LocationsViews: View {

    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700

    var body: some View {
        ZStack{
            mapLayer
                .ignoresSafeArea()
            VStack {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

// MARK: -Previews-
struct LocationsViews_Previews: PreviewProvider {
    static var previews: some View {
        LocationsViews()
            .environmentObject(LocationsViewModel())
    }
}

// MARK: -LocationsViews-extension-
extension LocationsViews {

    private var header: some View {
        VStack(spacing: 0) {
            Button(action: vm.toggleLocationsList) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? -180 : 0))
                    }
            }

            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }

    private var mapLayer: some View {
        //            Map(coordinateRegion: $vm.mapRegion)
        //                .ignoresSafeArea()
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location)
                    }
            }
        }
    }

    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
