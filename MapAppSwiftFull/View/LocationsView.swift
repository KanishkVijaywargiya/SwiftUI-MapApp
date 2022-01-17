//
//  LocationsView.swift
//  MapAppSwiftFull
//
//  Created by KANISHK VIJAYWARGIYA on 07/01/22.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationsDetailView(location: location)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
            .preferredColorScheme(.dark)
    }
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button(action: {
                vm.impact(style: .heavy)
                vm.haptic(type: .success)
                vm.toggleLocationsList()
            }) {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 50)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }
            
            if vm.showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView(image: location.imageNames.first!)
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7 )
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.impact(style: .heavy)
                        vm.haptic(type: .success)
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
}
