//
//  SingleStreamView.swift
//  CombineDemo
//
//  Created by Kevin Minority on 7/31/19.
//  Copyright © 2019 Kevin Cheng. All rights reserved.
//

import SwiftUI
import Combine

struct SingleStreamView: View {

    @ObservedObject var viewModel: StreamViewModel<String>

    @EnvironmentObject var streamStore: StreamStore

    var color: Color = .green

    var displayActionButtons: Bool = true

    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text(viewModel.updatableDescription)
                .font(.system(.headline, design: .monospaced))
                .lineLimit(nil).padding()
            BallTunnelView(values: $viewModel.values, color: color,
                           animationSecond: viewModel.animationSeconds)
                .frame(maxHeight: 100)
            if displayActionButtons {
                HStack {
                    CombineDemoButton(text: "Subscribe", backgroundColor: .blue) {
                      self.viewModel.subscribe()
                    }
                    CombineDemoButton(text: "Cancel", backgroundColor: .red) {
                      self.viewModel.cancel()
                    }
                }.padding()
            }
            Spacer()
        }.navigationBarTitle(viewModel.updatableTitle)
        .navigationBarItems(trailing: trailingBarItem)
    }

    var trailingBarItem: some View {
        guard let dataStreamViewModel = viewModel as? DataStreamViewModel else {
            return AnyView(EmptyView())
        }
        let navigationLink = NavigationLink(destination: UpdateStreamView(viewModel:
            dataStreamViewModel.updateStreamViewModel)) {
            Text("Edit")
        }
        return AnyView(navigationLink)
    }
}

#if DEBUG
struct SingleStreamView_Previews: PreviewProvider {
    static var previews: some View {
        SingleStreamView(viewModel: StreamViewModel(title: "Stream A",
                                                    description: "Sequence(1,2,3,4,5)",
                                                    publisher: Empty().eraseToAnyPublisher()))
    }
}
#endif
