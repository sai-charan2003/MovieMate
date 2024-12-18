//
//  HomeView.swift
//  MovieMate
//
//  Created by Sai Charan on 13/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var selectedMovieId: String?
    @State private var isShowingSheet = false
    @State private var selectedUPcomingMove : UpcomingResult?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Trending Movies")
                    .padding()
                    .bold()
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 16) {
                        
                        ForEach(viewModel.items, id: \.self) { movie in
                            VStack {
                                MovieCardView(imageURL: movie.posterPath!, title: movie.title!)
                                    .onTapGesture {
                                        selectedMovieId = String(movie.id!)
                                        
                                        isShowingSheet = true
                                        
                                    }
 
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
  
                
                Text("Upcoming Movies")
                    .padding()
                    .bold()
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 16) {
                        
                        ForEach(viewModel.upcomingMovies, id: \.self) { movie in
                            VStack {
                                MovieCardView(imageURL: movie.posterPath!, title: movie.title!)
                                    .onTapGesture {
                                        selectedMovieId = String(movie.id!)
                                        isShowingSheet = true
                                        
                                    }

                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 10)
                
                Spacer()
            }
            .navigationTitle("Movies")
            .onAppear {
                viewModel.fetchTrendingMovies()
                viewModel.fetchUpcomingData()
            }
            .sheet(isPresented: $isShowingSheet) {
                NavigationView {
                    MovieDetailsContentView(
                        id: selectedMovieId
                    )
                    .navigationBarItems(leading: HStack {
                        
                        Image(systemName: "arrow.left")

                        Text("Back")
                            
                    }
                        .onTapGesture {
                            isShowingSheet = false
                        }
                    )
                    .onDisappear {
                        isShowingSheet = false
                    }
                }
            }

        }
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
