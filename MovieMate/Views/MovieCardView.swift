//
//  MovieCardView.swift
//  MovieMate
//
//  Created by Sai Charan on 15/12/24.
//

import SwiftUI
struct MovieCardView : View {
     let imageURL : String
     let title : String
    var body: some View {
        VStack {
            AsyncImage(url: URL(string : "https://image.tmdb.org/t/p/w500\(imageURL)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
                    
            } placeholder: {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
            }
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 100)
            
            
        }
        
    }
}
