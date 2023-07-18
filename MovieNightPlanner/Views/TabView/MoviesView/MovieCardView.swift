//
//  MovieCardView.swift
//  MovieNightPlanner
//
//  Created by Salih Özdemir on 13.07.2023.
//

import SwiftUI

struct MovieCardView: View {
    var title: String
    var originalTitle: String
    var releaseDate: String
    var originalLanguage: String
    var posterPath: String?
    
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: releaseDate)
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w92\(posterPath ?? "")")) { phase in
                switch phase {
                case .failure:
                    Image("poster-placeholder")
                        .resizable()
                        .frame(width: 92)
                        .scaledToFit()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 92)
                        
                default:
                    ProgressView()
                        .frame(width: 92)
                }
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2.weight(.semibold))
                Text(originalTitle.lowercased() == title.lowercased() ? "" : originalTitle)
                    .font(.headline.weight(.light))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                HStack{
                    Text("\(date?.formatted(.dateTime.year()) ?? releaseDate)")
                        .font(.headline.weight(.light))
                    
                    Spacer()
                    
                    Text(originalLanguage)
                        .font(.headline.weight(.light))
                }
            }
            .padding(.vertical, 10)
            .padding(.trailing, 10)
            
            Spacer()
        }
        .frame(height: 138)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 2)
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(title: "Movie Title", originalTitle: "Original Movie Title", releaseDate: "01.01.2023", originalLanguage: "French")
    }
}
