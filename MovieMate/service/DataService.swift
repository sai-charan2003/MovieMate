////
////  DataService.swift
////  MovieMate
////
////  Created by Sai Charan on 13/12/24.
////
//import Foundation
//
//struct DataService {
//    let baseURL : String = "https://api.themoviedb.org/3/movie/"
//    let apiKey : String? = Bundle.main.infoDictionary?["API_KEY"] as? String
//    func getMoviesData() async -> [MovieDetails] {
//        let url = URL(string: baseURL+"/trending/movie/day?api_key=\(apiKey)")
//        if let url {
//            let request = URLRequest(url: url)
//            do {
//                var (data,_) =  try await URLSession.shared.data(for: request)
//                print(data)
//                var Decoder = JSONDecoder()
//                let movieData = try Decoder.decode([MovieDetails].self, from: data)
//                
//                return movieData
//            } catch {
//                print(error)
//            }
//        }
//        return [MovieDetails]()
//        
//        
//        
//    }
//}
