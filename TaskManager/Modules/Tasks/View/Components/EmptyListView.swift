//
//  EmptyListView.swift
//  TaskManager
//
//  Created by Jorge Filipe Correia Pinto on 09/11/2025.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "checkmark.circle")
                .font(.system(size: 60))
                .foregroundStyle(.gray)
            
            Text("Nenhuma tarefa")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Adicione sua primeira tarefa tocando no botão +")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    EmptyListView()
}
