//
//  LandmarkRowView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//

import SwiftUI

struct LandmarkRowView: View {
    var landmark: Landmark

    var body: some View {
        HStack {
            Image(landmark.imageName)
                .resizable()
                .frame(width: 70, height: 50)
            VStack(alignment: .leading) {
                Text(landmark.jname)
                    .font(.title3)
                Text(landmark.name)
                    .font(.subheadline)
                    .italic()
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            RatingsView(filter: landmark.name)
        }
    }
}

struct LandmarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkRowView(landmark: Landmark.allLandmarks[0])
    }
}
