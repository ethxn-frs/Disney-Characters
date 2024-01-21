//
//  SettingsView.swift
//  Disney Characters
//
//  Created by Etang on 21/01/2024.
//

import SwiftUI

struct SettingsView: View {
    
    let viewModel: SettingsViewViewModel
    
    init(viewModel: SettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.original)
                    //.foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.red)
                        .padding(8)
                        .background(Color(viewModel.iconContainerColor))
                        .cornerRadius(6)
                }
                Text(viewModel.title)
                    .padding(.leading, 10)
            }
            .padding(.bottom, 3)
        }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews : some View {
        SettingsView(viewModel: .init(cellViewModels: SettingsOption.allCases.compactMap({
            return SettingsCellViewModel(type: $0)
        })))
    }
}
