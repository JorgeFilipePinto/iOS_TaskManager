//
//  LoadingView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 07/11/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.gray.opacity(0.8))
                .edgesIgnoringSafeArea(.all)
            VStack {
                ProgressView("Loading...")
                    .foregroundStyle(.white)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(1.5, anchor: .center)
                    .padding()
                Text("Please wait while we load your data.")
                    .font(.headline)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    LoadingView()
}
