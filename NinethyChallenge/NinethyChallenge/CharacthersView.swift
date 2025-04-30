import SwiftUI

struct CharacterView: View {
    let character: HaPo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Seção da Imagem
                if let imageUrl = character.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 200)
                    }
                }
                
                // Seção de Informações Básicas
                VStack(alignment: .leading, spacing: 8) {
                    Text(character.name ?? "Nome desconhecido")
                        .font(.largeTitle)
                        .bold()
                    
                    HStack(spacing: 16) {
                        InfoBadge(title: "Casa", value: character.house ?? "-")
                        InfoBadge(title: "Nascimento", value: character.dateOfBirth ?? "-")
                        InfoBadge(title: "Espécie", value: character.species ?? "-")
                    }
                }
                
                // Seção Detalhada
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
                
                // Outras Informações
                if let alternateNames = character.alternate_names, !alternateNames.isEmpty {
                    DetailSection(title: "Nomes alternativos", content: [
                        "Outros nomes": alternateNames.joined(separator: ", ")
                    ])
                }
            }
            .padding()
        }
        .navigationTitle(character.name ?? "Personagem")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

// Componente de Badge de Informação
struct InfoBadge: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.subheadline)
                .bold()
        }
        .padding(8)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

// Componente de Seção Detalhada
struct DetailSection: View {
    let title: String
    let content: [String: String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title3)
                .bold()
                .padding(.top, 8)
            
            ForEach(content.sorted(by: >), id: \.key) { key, value in
                HStack {
                    Text(key)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(value)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}
