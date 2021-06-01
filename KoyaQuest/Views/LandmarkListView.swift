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
        NavigationView {
            List{
                ForEach(Landmark.allSections, id: \.self) { section in
                    Section(header: Text("\(section.rawValue)")) {
                        ForEach(Landmark.allLandmarks) { landmark in
                            if landmark.section == section {
                                NavigationLink(
                                    destination: LandmarkDetailView(locationManager: locationManager, landmark: landmark)
                                ) {
                                    LandmarkRowView(landmark: landmark)
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle(Text("Points of Interest"))
            }
            .padding(.bottom, 10)
        }
    }
}
    struct LandmarkListView_Previews: PreviewProvider {
        static var previews: some View {
            LandmarkListView(locationManager: LocationManager())
        }
    }
