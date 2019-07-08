//

import Foundation
import SwiftUI

extension HourlyDatum: Identifiable {
    var id: Date { time }
}

extension DailyDatum: Identifiable {
    var id: Date { time }
    
}
