//
//  MapAppSwiftFullApp.swift
//  MapAppSwiftFull
//
//  Created by KANISHK VIJAYWARGIYA on 07/01/22.
//

import SwiftUI

@main
struct MapAppSwiftFullApp: App {
    @StateObject private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
