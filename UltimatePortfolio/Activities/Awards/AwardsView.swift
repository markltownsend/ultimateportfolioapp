//
//  AwardsView.swift
//  UltimatePortfolio
//
//  Created by Mark Townsend on 11/19/20.
//

import SwiftUI

struct AwardsView: View {
    static let tag: String? = "Awards"

    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }

    @StateObject var viewModel: ViewModel

    @State private var selectedAward = Award.example
    @State private var showingAwardDetails = false

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        StackNavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            selectedAward = award
                            showingAwardDetails = true
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(color(for: award))
                        }
                        .accessibilityLabel(label(for: award))
                        .accessibilityHint(Text(award.description))
                        .buttonStyle(ImageButtonStyle())
                    }
                }
            }
            .navigationTitle("Awards")
        }
        .alert(isPresented: $showingAwardDetails, content: getAwardAlert)
    }

    // MARK: - Helper functions
    func color(for award: Award) -> Color {
        viewModel.color(for: award).map { Color($0) } ?? Color.secondary.opacity(0.5)
    }

    func label(for award: Award) -> Text {
        Text(viewModel.label(for: award))
    }

    func getAwardAlert() -> Alert {
        if viewModel.hasEarned(award: selectedAward) {
            return Alert(
                title: Text("Unlocked: \(selectedAward.name)"),
                message: Text("\(Text(selectedAward.description))"),
                dismissButton: .default(Text("OK"))
            )
        } else {
            return Alert(
                title: Text("Locked"),
                message: Text("\(Text(selectedAward.description))"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView(dataController: .preview)
    }
}
