//

import Foundation
// {"code":403,"error":"daily usage limit exceeded"}

struct JSONError: Codable {
    let code: Int
    let error: String
}
