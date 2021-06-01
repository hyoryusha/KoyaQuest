//
//  RatinsgInputView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI
import CoreData

struct RatingsInputView: View {
    @Environment(\.managedObjectContext) var viewContext : NSManagedObjectContext
    @EnvironmentObject var appData: AppData
    @Binding var rating : Int
    var locationManager: LocationManager
    var landmark: Landmark
    var label = "Add your rating:"
    var onImage = Image(systemName: RatingsConstants.onImage)
    var offImage = Image(systemName: RatingsConstants.offImage)
    
    var body: some View {
        VStack {
            Divider()
                .background(Color.koyaOrange)
                .padding()
            if landmark.area == locationManager.activeArea?.identifier {
                HStack{
                    if label.isEmpty == false {
                        Text(label.uppercased())
                            .font(.body)
                            .kerning(0.2)
                            .foregroundColor(Color.koyaOrange)
                    }
                    ForEach(1..<RatingsConstants.maxRating + 1 ) { number in
                        self.image(for: number)
                            .foregroundColor(Color.koyaOrange)
                            .onTapGesture {
                                rating = number
                                
        //MARK: - Enter into Core Data:
        //for testing I'm using mock userID 0
                                Rating.createWith(landmark: landmark.name, rating: Int16(number), userID: Int16(0), date: Date(), using: self.viewContext)
                                self.appData.recordLocalRating(landmark: landmark.name, stars: rating)
                            }
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }
}

struct RatingsInputView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsInputView(  rating: .constant(2), locationManager: LocationManager(), landmark: Landmark.allLandmarks[0] )
    }
}
