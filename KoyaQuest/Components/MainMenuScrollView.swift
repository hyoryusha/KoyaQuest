//
//  MainMenuScrollView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct MainMenuScrollView: View {
    @StateObject var locationManager = LocationManager()
    @Binding var selection: Landmark

    var body: some View {
        VStack(spacing: 2) {
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(Landmark.allLandmarks) { landmark in
                            Button {
                                selection = landmark
                            } label: {
                                Image(landmark.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 80, alignment: .center)
                                    .border(Color(.yellow),
                                            width: landmark.area == locationManager.activeArea?.identifier  ? 4 : 0)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                                    .padding(2)
                            }
                            .id(landmark.id)
                        }
                        .onChange(of: locationManager.scrollIndex) { _ in
                            scrollView.scrollTo(locationManager.scrollIndex)
                        }
                    }
                    .frame(height: 80)
                }
                Group {
                    Text("Nearby locations are highlighted in ")
                        .font(.caption2)
                        .foregroundColor(.primary)
                        .italic()
                     + Text("yellow.")
                        .font(.caption2)
                        .foregroundColor(.yellow)
                        .bold()
                        .italic()
                }
                .padding(.bottom, 8)
            }
        }
    }
}

struct MainMenuScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuScrollView(selection: .constant(Landmark.allLandmarks[0]))
    }
}
