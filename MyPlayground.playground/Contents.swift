import Foundation

extension String {
    func toJadenCase() -> String {
        self.capitalized
    }
}
let jadenWord = "most trees are blue"
jadenWord.toJadenCase()
