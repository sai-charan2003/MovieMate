import Foundation

class HomeViewModel: ObservableObject {
    @Published var items = [Result]()
    @Published var upcomingMovies = [UpcomingResult]()
    @Published var movieDetails: MovieDetails?
    @Published var movieDetailsState : ProcessState<MovieDetails> = .loading
    private let apiKey: String? = Bundle.main.infoDictionary?["API_KEY"] as? String
    private let baseURL: String = "https://api.themoviedb.org/3"
    
    func fetchTrendingMovies() {
        guard let apiKey = apiKey else {
            print("API key not found")
            return
        }
        
        guard let url = URL(string: "\(baseURL)/trending/movie/day?&api_key=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error during data task: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                
                let result = try JSONDecoder().decode(TrendingMoviesDTO.self, from: data)
                print(result)
                
                DispatchQueue.main.async {
                    self.items = result.results!
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchUpcomingData() {
        print("Requesting for upcoming movies")
        
        guard let api = apiKey else {
            print("API key is missing")
            return
        }
        
        guard let url = URL(string: "\(baseURL)/movie/upcoming?api_key=\(api)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            print("Received data: \(data)")
            
            do {
                let result = try JSONDecoder().decode(UpcomingMovies.self, from: data)
                
                
                DispatchQueue.main.async {
                    if let movies = result.results {
                        self.upcomingMovies = movies
                    } else {
                        print("No upcoming movies found")
                    }
                }
            } catch {
                print("JSON Decoding Error: \(error.localizedDescription)")
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
            }
        }.resume()
    }

    
    func fetchMovieDetails(id: String) {
        guard let apiKey = apiKey else {
            print("API key is missing")
            return
        }
        guard let url = URL(string: "\(baseURL)/movie/\(id)?api_key=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.movieDetailsState = .failure(error)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {

                let result = try JSONDecoder().decode(MovieDetails.self, from: data)
                print(result)
                DispatchQueue.main.async {
                    self.movieDetailsState = .success(result)
                }
            } catch {
                self.movieDetailsState = .failure(error)
            }
        }.resume()
    }



}
