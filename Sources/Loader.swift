import Foundation

func loader(day: Int) -> String? {
    let path = "./Inputs/\(day).txt"
    let url = URL(fileURLWithPath: path)
    return try? String(contentsOf: url)
}
