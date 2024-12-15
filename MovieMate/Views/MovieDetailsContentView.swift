import SwiftUI

struct MovieDetailsContentView: View {
    @State var id: String?
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            switch viewModel.movieDetailsState {
            case .loading:
                ProgressView()
                    .frame(maxHeight: .infinity, alignment: .center)

            case .success(let movieDetails):
                VStack {
                    // Backdrop Image
                    if let backdropPath = movieDetails.backdropPath,
                       let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)") {
                        AsyncImage(url: backdropURL) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .mask {
                                        LinearGradient(
                                            colors: [
                                                Color.black.opacity(0.2),
                                                Color.black.opacity(1),
                                                Color.black.opacity(0)
                                            ],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    }
                            case .failure:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 200)
                                    .overlay(Text("Image not available"))
                            default:
                                ProgressView()
                                    .frame(height: 200)
                            }
                        }
                    }

                    // Poster Image
                    if let posterPath = movieDetails.posterPath,
                       let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                        AsyncImage(url: posterURL) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 225)
                                    .cornerRadius(12)
                            case .failure:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 150, height: 225)
                                    .cornerRadius(12)
                                    .overlay(Text("Image not available"))
                            default:
                                ProgressView()
                                    .frame(width: 150, height: 225)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.top, -150)
                    }

                    // Movie Title
                    if let title = movieDetails.title {
                        Text(title)
                            .font(.title2)
                            .bold()
                            .padding(.top, 8)
                    } else {
                        Text("No title available")
                            .font(.title2)
                            .bold()
                            .padding(.top, 8)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)

            case .failure(let error):
                VStack {
                    Text("Error occurred:")
                        .font(.headline)
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .onAppear {
            guard let movieID = id else { return }
            viewModel.fetchMovieDetails(id: movieID)
        }
    }
}

struct MovieDetailsContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsContentView(id: "12345")
    }
}
