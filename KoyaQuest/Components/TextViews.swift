//
//  TextViews.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//


import SwiftUI

struct HeaderText: View {
    var text: String
    var color: Color
        var body: some View {
            Text(text)
                .italicHeader()
        }
}

struct BodyText: View {
    var text: String
    var color: Color
        var body: some View {
            Text(text)
                .bodyStyle()
        }
}


struct HeaderBodyTextViews_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack{
            HeaderText(text: Landmark.allLandmarks[0].details.headerOne, color: Color.koyaOrange)
            BodyText(text: Landmark.allLandmarks[0].details.bodyOne, color: Color.koyaDarkText)
            HeaderText(text: Landmark.allLandmarks[0].details.headerTwo, color: Color.koyaOrange)
            BodyText(text: Landmark.allLandmarks[0].details.bodyTwo, color: Color.koyaDarkText)
        }
        
    }
}

