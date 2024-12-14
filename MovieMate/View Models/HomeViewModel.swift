import Foundation

class HomeViewModel: ObservableObject {
    @Published var items = [Result]()
    private let apiKey: String? = Bundle.main.infoDictionary?["API_KEY"] as? String
    private let baseURL: String = "https://api.themoviedb.org/3/trending/movie/day"

    func fetchData() {
        guard let apiKey = apiKey else {
            print("API key not found")
            return
        }

        guard let url = URL(string: "\(baseURL)?&api_key=\(apiKey)") else {
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
                print(data)
                let result = try JSONDecoder().decode(MoviesdDetails.self, from: data)
                print(result.results)
                DispatchQueue.main.async {
                    self.items = result.results!
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
