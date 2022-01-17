//
//  LocationsDetailView.swift
//  MapAppSwiftFull
//
//  Created by KANISHK VIJAYWARGIYA on 17/01/22.
//

import SwiftUI
import MapKit

struct LocationsDetailView: View {
    @EnvironmentObject private var vm: LocationsViewModel
    @Environment(\.dismiss) var dismissMode
    let location: Location
    @State var wikiLink = false
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 15) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading, content: {
            backButton
        })
        .fullScreenCover(isPresented: $wikiLink) {
            SafariView(url:URL(string: location.link)!)
        }
    }
}

struct LocationsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Read more on Wikipedia")
                .font(.headline)
                .foregroundColor(.blue)
                .onTapGesture {
                    vm.impact(style: .heavy)
                    vm.haptic(type: .success)
                    self.wikiLink = true
                }
        }
    }
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))), annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView(image: location.imageNames.first!)
                    .shadow(radius: 10)
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
    }
    private var backButton: some View {
        Button(action: {
            vm.impact(style: .heavy)
            vm.haptic(type: .success)
            vm.sheetLocation = nil
            dismissMode()
        }) {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.primary)
                .background(.thickMaterial)
                .clipShape(Circle())
                .shadow(radius: 4)
                .padding()
        }
    }
}
