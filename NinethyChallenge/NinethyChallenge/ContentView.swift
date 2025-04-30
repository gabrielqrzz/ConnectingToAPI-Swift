import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .red, .black]), startPoint: .top, endPoint: .bottom)

                VStack {
                    Image(.unnamed).resizable().frame(width: 400, height: 300)
                    ScrollView {
                        ForEach(viewModel.personagens) { personagem in
                            NavigationLink(destination: CharacterView(character: personagem)) {
                                HStack {
                                    if let imageUrl = personagem.image, let url = URL(string: imageUrl) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 80, height: 80)
                                        } placeholder: {
                                            ProgressView()
                                                .progressViewStyle(CircularProgressViewStyle())
                                                .frame(width: 80, height: 80)
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Text(personagem.name ?? "")
                                            .font(.headline).foregroundStyle(.white)
                                        if let species = personagem.species {
                                            Text(species)
                                                .font(.subheadline)
                                                .foregroundStyle(.white)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                            
                            .padding(.vertical, 5)
                        }
                    }
                }
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            .onAppear {
                viewModel.fetch()
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

