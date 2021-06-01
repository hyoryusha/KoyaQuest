//
//  LocalRatingsView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI
import SwiftUI

struct LocalRatingsView: View {
    @EnvironmentObject var appData: AppData
    var landmark: Landmark
    var label = "Your rating:"
    
    var body: some View {
        VStack{
            Divider()
                .background(Color.koyaOrange)
            HStack{
                if label.isEmpty == false {
                    Text(label.uppercased())
                        .font(.body)
                        .kerning(0.2)
                        .foregroundColor(Color.koyaOrange)
                }
                ForEach(1..<RatingsConstants.maxRating + 1 ) { number in
                    if number > getLocalRating() {
                    } else {
                        Image(systemName: RatingsConstants.onImage)
                    }
                }
            }
            .foregroundColor(.yellow)
            .font(.caption)
        }
    }
        
    func getLocalRating() -> Int {
        let index = appData.localRatings.firstIndex(where: {$0.landmark == landmark.name })! //safe to force unwrap as this view only appears if there is a rating
        let rating = appData.localRatings[index].stars
       return rating
   }
}

struct LocalRatingsView_Previews: PreviewProvider {
    static var previews: some View {
        LocalRatingsView(landmark: Landmark.allLandmarks[0])
    }
}
