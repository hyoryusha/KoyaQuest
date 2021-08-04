//
//  TitleImageView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import CoreData

struct TitleImageView: View {
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    let landmark: Landmark

    var body: some View {
        Image(landmark.imageName)
            .resizable()
            // .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
            .border(Color.white)
            .scaledToFit()
            .padding([.leading, .trailing], 40)
            .padding(.top, 16)
            .layoutPriority(1)
            .overlay(TextOverlayView(landmark: landmark))
            .overlay(RatingsOverlayView(landmark: landmark))
    }
}

struct TitleImageView_Previews: PreviewProvider {
    static var previews: some View {
        TitleImageView(landmark: Landmark.allLandmarks[0])
    }
}
