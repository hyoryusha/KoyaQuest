//
//  LandmarkDetailView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//

import SwiftUI

struct LandmarkDetailView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var appData: AppData
    @ObservedObject var locationManager : LocationManager
    @State private var rating = 0
    @State private var isShowingRatingsView = false
    var landmark: Landmark
    
    var body: some View {
        ZStack{
            BackgroundView()
            VStack {
                
                Text(landmark.jname)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.koyaOrange)
                    .navigationBarTitle("Detail View")
                    .navigationBarHidden(true)
                
                ScrollView{
                    Image(landmark.imageName)
                        .resizable()
                        .shadow(radius: 6 )
                        .scaledToFit()
                        .padding([.leading, .trailing], 20)
                        .padding([.top, .bottom], 12)
                        .layoutPriority(2)
                        .overlay(RatingsOverlayView(landmark: landmark))
                    HeaderText(text: landmark.name, color: Color.koyaRed)
                    BodyText(text: landmark.details.bodyOne, color: Color.koyaLightText)
                    HeaderText(text: landmark.details.headerTwo, color: Color.koyaRed)
                    BodyText(text:landmark.details.bodyTwo, color: Color.koyaLightText)
                }
                .onAppear() {
                
                }
                .padding([.bottom, .leading, .trailing], 6)

                if checkLocalRating() {
                    LocalRatingsView(landmark: landmark)
                        .padding(.bottom, 10)
                        .animation(.easeInOut(duration: 0.8))
                } else {
                    RatingsInputView( rating: $rating, locationManager: locationManager, landmark: landmark)
                    .padding(.bottom, 10)
                    .animation(.easeInOut(duration: 0.8))
                }
                
                NavigationLink(destination: MapView(target: landmark)) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundColor(Color.koyaDarkText)
                        Text("See on map".uppercased())
                        .font(.caption)
                            .foregroundColor(Color.koyaDarkText)
                 }
                SmallDismissButton(buttonText: "Back")
            }
            .padding(.bottom, 14)
        }
     }
    
    
     func checkLocalRating() -> Bool {
        if appData.localRatings.contains(where: {$0.landmark == landmark.name}) {
            return true
        } else {
            return false
        }
    }
}

struct LandmarkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetailView(locationManager: LocationManager(), landmark: Landmark.allLandmarks[0])
    }
}
