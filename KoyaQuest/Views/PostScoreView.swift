//
//  UserInputView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/14.
//

import SwiftUI
import CoreData

struct PostScoreView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    //@Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext // changed 9-29-21 to:
    @EnvironmentObject var dataController: DataController
    @StateObject var viewModel = PostScoreViewModel()
    @State var showAllUsernames: Bool = false
    @State var scorePosted: Bool = false
    @Binding var isShowingForm: Bool
    @Binding var hidePostScoreButton: Bool

//get the usernames here; pass to other views as needed
    let fetchRequest = FinalScore.basicFetchRequest()
    var finalScores : FetchedResults<FinalScore> {
        fetchRequest.wrappedValue
    }

    var userNamesArray: [String] {
        finalScores.compactMap { $0.userName }
    }


    var body: some View {
        VStack {
            TitleView(fullCaption: false)
            if scorePosted {
                Text("Success!")
                    .font(.title)
                    .bold()
                    .foregroundColor(.koyaGreen)
                    .padding()
                Text("Your score has been posted to the leaderboard!")
                    .font(.headline)
                    .italic()
                Divider()
                    .padding(.bottom, 6)
                LeaderboardView(viewModel: LeaderboardViewModel(),  fetchFilter: FinalScoreFilter.allTime)
            } else {
                VStack {
                    Text("Congratulations!".uppercased())
                        .font(.title2)
                        .bold()
                        .padding(10)
                        .foregroundColor(Color.koyaPurple)
                    Text("Share your accomplishment with the world!*")
                        .font(.body)
                        .bold()
                        .multilineTextAlignment(.center)
                }
                Form {
                    Section(header: Text("How do you want your name to appear?")) {
                        TextField("...enter your username here...", text: $viewModel.userName)
                            .padding(.leading, 12)
                            .background(Color.koyaSky)
                            .disableAutocorrection(true)
                        Button{
                            viewModel.checkUserNameAvailable(userNamesArray: userNamesArray)
                            viewModel.saveChanges()
                        } label: {
                            Text("Post Your Score of \(appData.totalScore) Points")
                        }
                        .alert(isPresented: $viewModel.showingEmptyFormAlert) {
                            Alert(title: Text("Missing information"),
                                  message: Text("Please enter a username"),
                                  dismissButton: .default(Text("Okay")))
                        }
                    }
                } // end form
                .frame(height: 142, alignment: .center)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .padding()
                PostScoreBlurbView()
            }
            Spacer()
        } // end Vstack
        .onChange(of: viewModel.readyToPostScore) {_ in
            hidePostScoreButton = true
            if viewModel.readyToPostScore == true {
                let newRecord = FinalScoreRecord(userName: viewModel.userName, date: Date(), score: viewModel.totalScore)
                FinalScore.createWith(userIdentifier: UUID().uuidString,
                                      userName: newRecord.userName,
                                      score: newRecord.score,
                                      submitDate: newRecord.date,
                                      using: dataController.container.viewContext)
                scorePosted = true
            }
        }
        .onAppear {
            viewModel.totalScore = Int16(appData.totalScore)
        }
        .sheet(isPresented: $showAllUsernames, content: {
            AllUserNamesView(userNamesArray: userNamesArray)
        })
        .background(Image("mtns")
        .scaledToFill()
        .edgesIgnoringSafeArea([.all]))
        .statusBar(hidden: true)
        .alert(isPresented: $viewModel.showingActionAlert) {
            Alert(title: Text("User Name Unavailable"),
                  message: Text("The username you selected is already in use. Try entering a different name."),
                primaryButton: .cancel(Text("Got it!")),
                secondaryButton: .default(Text("View UserNames") , action: {
                    showAllUsernames = true
                }
                ))
            }
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        PostScoreView(isShowingForm: .constant(true), hidePostScoreButton: .constant(false))
            .environmentObject(AppData())
    }
}

struct PostScoreBlurbView: View {
    var body: some View {
        Text("(Well, those who use this app, at least.)")
            .font(.footnote)
            .foregroundColor(.koyaDarkText)
            .italic()
            .padding()
    }
}
