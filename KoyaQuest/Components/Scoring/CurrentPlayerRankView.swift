//
//  CurrentPlayerRankView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/22.
//

import SwiftUI
import CoreData

struct CurrentPlayerRankView: View {
    var fetchRequest: FetchRequest<FinalScore>
    var score: FetchedResults<FinalScore> { fetchRequest.wrappedValue }
    var userName: String
    var body: some View {
        Text("\(userName)'s score should appear here with the date.")
            .font(.subheadline)
            .foregroundColor(.koyaGreen)
    }
    init(userName: String) { // this is the param to be supplied when the View is called in ContentView
        self.userName = userName
        fetchRequest = FetchRequest<FinalScore>(entity: FinalScore.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "userName" , userName))
    }
}

struct CurrentPlayerRankView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentPlayerRankView(userName: "Name")
    }
}
