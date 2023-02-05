//
//  ManualLocationPickerView.swift
//  Weather
//
//  Created by Oleh Kiurchev on 04.02.2023.
//

import SwiftUI
import CoreLocation

struct ManualLocationPickerView: View {
    @State private var showSearchLocationView = false

    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            Spacer()
            Spacer()

            Image(systemName: "location.slash.fill")
                .foregroundColor(.accentColor)
                .font(.system(size: 70))

            VStack(alignment: .center, spacing: 10) {
                Text("Location services is off")
                    .font(.system(.title2))
                Text("Please, select location for weather manually")
                    .font(.system(.body))
            }
            
            Spacer()
            
            Button {
                showSearchLocationView.toggle()
            } label: {
                Text("Select location")
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(Color.accentColor)
            .foregroundColor(Color.white)
            .clipShape(Capsule())

            Spacer()
        }
        .ignoresSafeArea()
        .foregroundColor(Color.secondary)
        .fullScreenCover(isPresented: $showSearchLocationView) {
            SearchLocationView()
        }
    }
}

struct ManualLocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ManualLocationPickerView()
    }
}
