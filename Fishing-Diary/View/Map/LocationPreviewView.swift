//
//  LocationPreviewView.swift
//  Fishing-Diary
//
//  Created by Joni Lassila on 3.1.2023.
//

import SwiftUI

struct LocationPreviewView: View {
    
    let fish: Fish
    
    @State var image : Data = .init(count: 0)
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
            
            VStack(spacing: 8) {
                openButton
                nextButton
                
            }
        }
        .padding(20)
        .background(
        RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial)
            .offset(y: 65)
        )
        .cornerRadius(10) // Or .clipped, delivers the same purpose, corner radius adds a little cornering to the bottom right and left
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let fish = context.firstFishes
        ZStack {
            Color.purple.ignoresSafeArea()
            LocationPreviewView(fish: fish)
                .padding()
        }
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            Image(uiImage: (UIImage(data: fish.imageData ?? self.image) ?? UIImage(named: "kalakuva")!))
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(fish.title ?? "No title found")
                .font(.title2)
                .fontWeight(.bold)
            Text(fish.timestamp ?? Date(), formatter: itemFormatter)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var openButton: some View {
        Button {
            
        } label: {
            Text("Open")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
}
