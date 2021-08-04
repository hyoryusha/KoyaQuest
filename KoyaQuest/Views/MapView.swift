//
//  MapView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region: MKCoordinateRegion
    @State private var mapType: MKMapType = . standard

    var target: Landmark
    var places: [PlaceAnnotation] = allPlaces
    init(target: Landmark) {
        _region = State(initialValue: target.LMregion)
        self.target = target
    }
        var body: some View {
        ZStack {
            MapViewUI(location: target, mapViewType: mapType, places: places )
              VStack {
                HStack {
                  Spacer()
                }
                .padding()
                Spacer()
                VStack {
                    Picker("", selection: $mapType) {
                        Text("Standard").tag(MKMapType.standard)
                        Text("Satellite").tag(MKMapType.satellite)
                        Text("Hybrid").tag(MKMapType.hybrid)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .background(Color.koyaSky)
                .offset(y: -26)
                BackButton(buttonText: "Back")
                    .padding(.bottom, 28)
              }

        } // end zstack
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
      }
    }

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(target: Landmark.allLandmarks[0])
    }
}
