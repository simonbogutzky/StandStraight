//
//  MainView.swift
//  StandStraight
//
//  Created by Dr. Simon Bogutzky on 24.10.21.
//

import SwiftUI
import CoreMotion

struct MainView: View {

    @StateObject var viewModel = MainViewModel()

    var body: some View {
        ZStack {
            VStack {

                Spacer()

                Text(viewModel.attituteRollInDegree != nil
                     ? "Roll: \(viewModel.attituteRollInDegree!, specifier: "%.1f°")"
                     : "--")
                .font(.title)
                .fontWeight(.semibold)

                Spacer()

                Button {
                    if !viewModel.deviceMotionUpdatesAreRunning {
                        viewModel.startHeadphoneMotionUpdates()
                    } else {
                        viewModel.stopHeadphoneMotionUpdates()
                    }
                } label: {
                    Text(!viewModel.deviceMotionUpdatesAreRunning
                         ? "Start headphone motion updates"
                         : "Stop headphone motion updates")
                }
                .modifier(StandardButtonStyle())
                .padding(.bottom, 38)
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
