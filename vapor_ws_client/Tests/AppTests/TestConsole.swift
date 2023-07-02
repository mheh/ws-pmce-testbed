import Vapor

final class TestConsole: Console {

    var testInputQueue: [String]
    var testOutputQueue: [String]
    var userInfo: [AnyHashable : Any]

    init() {
        self.testInputQueue = []
        self.testOutputQueue = []
        self.userInfo = [:]
    }

    func input(isSecure: Bool) -> String {
        testInputQueue.popLast() ?? ""
    }

    func output(_ text: ConsoleText, newLine: Bool) {
        let line = text.description + (newLine ? "\n" : "")
        testOutputQueue.insert(line, at: 0)
    }

    func report(error: String, newLine: Bool) {
        //
    }

    func clear(_ type: ConsoleClear) {
        //
    }

    var size: (width: Int, height: Int) {
        (0, 0)
    }
}
