////
////  ContentView.swift
////  MovieMate
////
////  Created by Sai Charan on 12/12/24.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    let baseURL = "https://api.themoviedb.org/3"
//    let apiKey = "38795e6decb3f2a4ebea79725e5721d2"
//    var body: some View {
//        VStack {
//            Button("Get API key"){
//                Task {
//                    await getTrendingMovies()
//                }    	
//            }
//        }
//         
//            
//        
//            
//    }
//    
//    func getTrendingMovies() async {
//        let url = URL(string: baseURL+"/trending/movie/day?api_key=\(apiKey)")
//        
//        if let url = url {
//            let request = URLRequest(url: url)
//            do {
//                var (data , response) = try await URLSession.shared.data(for: request)
//                print(data)
//                print(response)
//                
//            } catch {
//                print(error)
//                
//            }
//        }
//        
//        
//        
//        
//        
//        
//    }
//    
//}
//
//#Preview {
//    ContentView()
//}
