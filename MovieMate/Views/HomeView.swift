//
//  HomeView.swift
//  MovieMate
//
//  Created by Sai Charan on 13/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items,id: \.self){ movies in
                    HStack {
                        
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movies.backdropPath!)")) { image in
                            image
                                .resizable()
                            
                                .frame(width: 100, height: 50)
                                .cornerRadius(8)
                                .aspectRatio(contentMode : .fill)
                                
                            
                        } placeholder: {
                            ProgressView()
                        }
                            Text(movies.title ?? "New")
                        
                            
                        
                        
                    }
                    
                    
                    .padding(.vertical,10)
                    .listRowSeparator(.hidden)
                    
                    
                }
            }
            .listStyle(PlainListStyle())
            
            
            
            
            
            .navigationTitle("Trending Movies")
            .onAppear{
                viewModel.fetchData()
            }
            
        }

    }
}

struct HomeView_Preview : PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
