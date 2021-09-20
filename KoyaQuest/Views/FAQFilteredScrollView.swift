//
//  FAQFilteredScrollView.swift
//  SearchFeatureTest
//
//  Created by Kevin K Collins on 2021/09/11.
//

import SwiftUI

struct FAQFilteredScrollView: View {
    @StateObject var viewModel = FAQViewModel()
    @State var isShowingAnswer = false
    @State private var filterString = ""
    @State private var filteredItems: [FAQ] = []
    @State private var initialState: Bool = true
    var body: some View {
        VStack {
             //NavigationView {
                ScrollView {
                    SearchBarView(text: $filterString.onChange(applyFilter))
                        .padding(.bottom, 30)
                    ForEach(FAQ.allCats, id: \.self) { category in
                        Section(header: FAQHeaderView(header: "\(category.rawValue)")) {
                            ForEach(initialState ? viewModel.faq : filteredItems) { faq in
                                    if faq.category == category {
                                        NavigationLink(destination: FAQDetailView(contents: faq, isShowingAnswer: $isShowingAnswer)) {
                                            Text(faq.title)
                                            .font(.body)
                                            .foregroundColor(.koyaDarkText)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .padding(.leading)
                                            Spacer()
                                            Divider()
                                            .background(Color(.systemGray4))
                                            .padding(.leading)
                                    }
                                }
                            }
                        }
                    }

                //}
                .onAppear() {
                    viewModel.getFAQ()
                    //applyFilter()
                }

//                    .navigationBarTitle("FAQ", displayMode: .automatic)
            }
                .padding()
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
    func applyFilter() {
        self.initialState = false
        let cleanedFilter = filterString.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanedFilter.isEmpty {
            filteredItems = viewModel.faq
        } else {
            filteredItems = viewModel.faq.filter { $0.filter
                   .localizedCaseInsensitiveContains(cleanedFilter)
            }
        }
    }
}

struct FAQFilteredScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FAQFilteredScrollView()
    }
}
