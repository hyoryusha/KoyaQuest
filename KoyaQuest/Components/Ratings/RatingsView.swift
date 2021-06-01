//
//  RatingsView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//

import SwiftUI
import CoreData

struct RatingsView: View {
    var fetchRequest: FetchRequest<Rating>
    
    var body: some View {

        HStack(spacing: 0.4){
            ForEach(1..<RatingsConstants.maxRating + 1 ) { number in
                if number > stars {
                    //Image(systemName:RatingsConstants.offImage)
                } else {
                    Image(systemName: RatingsConstants.onImage)
                }
            }
        }
        .shadow(color: Color.black, radius: 1, x: 1, y: 1)
        .padding(.trailing , 46)
        .foregroundColor(.yellow)
        .font(.caption)
    }
    
    
    init(filter: String) {
        fetchRequest = FetchRequest<Rating>(entity: Rating.entity() , sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "landmark" , filter))
    }
    var sum: Int16 {
        fetchRequest.wrappedValue.reduce(0) { $0 + $1.rating }
        }
    
    var stars : Int {
        var starCount:Int
        if fetchRequest.wrappedValue.count > 0 {
            starCount = Int(sum) / fetchRequest.wrappedValue.count
        } else {
            starCount = 0
        }
        return starCount
    }
}
