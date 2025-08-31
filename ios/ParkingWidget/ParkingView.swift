import SwiftUI
import WidgetKit

struct ParkingView: View {
    let parkingImageURL: String?
    let parkingSymbol: String
    let numberOfFreePlaces: String
    let trend: String
    
    private let widgetSize: CGFloat = 125
    private let whiteSoap = Color(red: 1.0, green: 0.99, blue: 0.99)
    private let blackMirage = Color(red: 0.16, green: 0.20, blue: 0.25)
    private let orangePomegranate = Color(red: 0.89, green: 0.24, blue: 0.20)
    
    var body: some View {
        ZStack {
            if let url = parkingImageURL, let imageURL = URL(string: url), !url.isEmpty {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: orangePomegranate))
                            .frame(width: widgetSize, height: widgetSize)
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: widgetSize, height: widgetSize)
                            .clipped()
                            .overlay(Color.black.opacity(0.25))
                        
                    case .failure:
                        blackMirage
                        
                    @unknown default:
                        blackMirage
                    }
                }
            } else {
                blackMirage
            }
            
            VStack {
                HStack {
                    Text(parkingSymbol)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(whiteSoap)
                        .padding(8)
                    Spacer()
                }
                Spacer()
                HStack {
                    Image(systemName: determineTrendIcon(trend: Int(trend) ?? 0))
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 8)
                    Spacer()
                    Text(numberOfFreePlaces)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(whiteSoap)
                        .padding([.bottom, .trailing], 8)
                }
            }
        }
        .frame(width: widgetSize, height: widgetSize)
        .cornerRadius(12)
    }
    
    private func determineTrendIcon(trend: Int) -> String {
        switch trend {
        case 1: return "arrow.up"
        case -1: return "arrow.down"
        case 0: return "equal"
        default: return "questionmark"
        }
    }
}

#Preview(as: .systemSmall){
    C13ParkingWidget()
} timeline: {
    ParkingWidgetEntry(date: .now, symbol: ParkingSymbol.C13.rawValue, freePlaces: "32", imageUrl: "https://cdn.pixabay.com/photo/2020/05/19/21/04/moon-5192647_1280.jpg", trend: "1")
}



