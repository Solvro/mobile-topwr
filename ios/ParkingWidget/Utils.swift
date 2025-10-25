import SwiftUI

func decodeParkingWidget(from jsonString: String, for symbol: ParkingSymbol) throws -> ParkingWidgetEntry {
    guard let data = jsonString.data(using: .utf8) else {
        throw NSError(domain: "InvalidString", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to convert string to Data"])
    }
    
    let parkingList = try JSONDecoder().decode([ParkingWidgetEntry].self, from: data)
    
    if let parkingData = parkingList.first(where: { $0.symbol == symbol.rawValue }) {
        return parkingData
    } else {
        throw NSError(domain: "SymbolNotFound", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parking with given symbol not found"])
    }
}
