//
//  LocationsListView.swift
//  MapApp
//
//  Created by Mahmoud Zinji on 2022-05-16.
//

import SwiftUI

struct LocationsListView: View {

    @EnvironmentObject private var vm: LocationsViewModel

    var body: some View {

        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.showNextLocation(location)
                } label: {
                    loadRowViews(with: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsListView {

    private func loadRowViews(with location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }

            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
