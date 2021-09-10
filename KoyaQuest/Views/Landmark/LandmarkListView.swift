//
//  LandmarkListView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//
import SwiftUI

struct LandmarkListView: View {
    var locationManager: LocationManager
    var body: some View {
       // NavigationView {
            List {
                ForEach(Landmark.allSections, id: \.self) { section in
                    Section(header: Text("\(section.rawValue)")) {
                        ForEach(Landmark.allLandmarks) { landmark in
                            if landmark.section == section {
                                NavigationLink(
                                    destination: LandmarkDetailView(locationManager: locationManager,
                                        landmark: landmark)
                                ) {
                                    LandmarkRowView(landmark: landmark)
                                }
                                .accessibility(label: Text("\(landmark.name)"))
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .padding(.bottom, 10)
            .statusBar(hidden: true)
       // }
        .navigationBarTitle(Text("Points of Interest"))
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView(locationManager: LocationManager())
    }
}
