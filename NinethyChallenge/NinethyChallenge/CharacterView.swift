import SwiftUI

struct CharacterView: View {
    let character: HaPo
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .red, .black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let imageUrl = character.image, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        } placeholder: {
                            ProgressView()
                                .frame(height: 200)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(character.name ?? "Nome desconhecido")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        HStack(spacing: 16) {
                            InfoBadge(title: "Casa", value: character.house ?? "-")
                            InfoBadge(title: "Nascimento", value: character.dateOfBirth ?? "-")
                            InfoBadge(title: "Espécie", value: character.species ?? "-")
                        }
                    }
                    
                    Group {
                        DetailSection(title: "Varinha", content: [
                            "Madeira": character.wand.wood ?? "-",
                            "Núcleo": character.wand.core ?? "-",
                            "Tamanho": character.wand.lenght != nil ? "\(character.wand.lenght!) cm" : "-"
                        ])
                        
                        DetailSection(title: "Características", content: [
                            "Gênero": character.gender ?? "-",
                            "Ascendência": character.ancestry ?? "-",
                            "Cor dos olhos": character.eyeColour ?? "-",
                            "Cor do cabelo": character.hairColour ?? "-"
                        ])
                        
                        DetailSection(title: "Ator", content: [
                            "Interpretado por": character.actor ?? "-",
                            "Patrono": character.patronus ?? "-"
                        ])
                        
                        if let alternateNames = character.alternate_names, !alternateNames.isEmpty {
                            DetailSection(title: "Nomes alternativos", content: [
                                "Outros nomes": alternateNames.joined(separator: ", ")
                            ])
                        }
                    }
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
                }
                .padding()
            }
        }
        .navigationTitle(character.name ?? "Personagem")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct InfoBadge: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            
            Text(value)
                .font(.subheadline)
                .bold()
                .foregroundColor(.white)
        }
        .padding(8)
        .background(Color.red.opacity(0.7))
        .cornerRadius(8)
    }
}

struct DetailSection: View {
    let title: String
    let content: [String: String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .padding(.top, 8)
            
            ForEach(content.sorted(by: >), id: \.key) { key, value in
                HStack {
                    Text(key)
                        .foregroundColor(.white.opacity(0.8))
                    Spacer()
                    Text(value)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        .padding()
    }
}

