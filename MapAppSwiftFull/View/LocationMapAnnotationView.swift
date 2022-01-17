//
//  LocationMapAnnotationView.swift
//  MapAppSwiftFull
//
//  Created by KANISHK VIJAYWARGIYA on 11/01/22.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    let accentColor = Color("AccentColor")
    var image: String
    
    var body: some View {
        VStack(spacing: 0) {
            Image(image)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: 30, height: 30)
                .padding(6)
                .background(accentColor)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(accentColor)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            LocationMapAnnotationView(image: "paris-eiffeltower-1")
        }
    }
}
