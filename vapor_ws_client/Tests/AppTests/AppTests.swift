//@testable import App
//import XCTVapor
//
//final class AppTests: XCTestCase {
//    
//    
//    func testAsyncConnectCommand_connects_to_url() async throws {
//        
//           let app = Application(.testing)
//           defer { app.shutdown() }
//           try await configure(app)
//           
//           let command = AsyncConnectCommand()
//           let arguments = ["url","ws://localhost:8080/test"]
//           
//           let console = TestConsole()
//           let input = CommandInput(arguments: arguments)
//           var context = CommandContext(
//               console: console,
//               input: input
//           )
//           context.application = app
//           
//           try console.run(command, with: context)
//
//           let output = console
//               .testOutputQueue
//               .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
//           
//           let expectation = [
//               "CONNECTED"
//           ]
//        var s = ""
//        for line in output {
//            s.append(line)
//        }
//        
//        XCTAssertContains(s, expectation.first!)
//       }
//    
//    func testAsyncConnectCommand_conects_with_cnct() async throws {
//        
//           let app = Application(.testing)
//           defer { app.shutdown() }
//           try await configure(app)
//           
//           let command = AsyncConnectCommand()
//           let arguments = ["url",
//                            "--client_no_context_takeover",
//                            "ws://localhost:8080/test",
//                            ]
//           
//           let console = TestConsole()
//           let input = CommandInput(arguments: arguments)
//           var context = CommandContext(
//               console: console,
//               input: input
//           )
//           context.application = app
//           
//           try console.run(command, with: context)
//
//           let output = console
//               .testOutputQueue
//               .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
//           
//           let expectation = [
//               "<test> true false nil nil"
//           ]
//        var s = ""
//        for line in output {
//            s.append(line)
//        }
//        
//        XCTAssertContains(s, expectation.first!)
//       }
//    
//    func testAsyncConnectCommand_conects_with_snct() async throws {
//        
//           let app = Application(.testing)
//           defer { app.shutdown() }
//           try await configure(app)
//           
//           let command = AsyncConnectCommand()
//           let arguments = ["url",
//                            "--server_no_context_takeover",
//                            "ws://localhost:8080/test",
//                            ]
//           
//           let console = TestConsole()
//           let input = CommandInput(arguments: arguments)
//           var context = CommandContext(
//               console: console,
//               input: input
//           )
//           context.application = app
//           
//           try console.run(command, with: context)
//
//           let output = console
//               .testOutputQueue
//               .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
//           
//           let expectation = [
//               "<test> false true nil nil"
//           ]
//        var s = ""
//        for line in output {
//            s.append(line)
//        }
//        
//        XCTAssertContains(s, expectation.first!)
//       }
//    
//    func testAsyncConnectCommand_conects_with_smwb15() async throws {
//        
//           let app = Application(.testing)
//           defer { app.shutdown() }
//           try await configure(app)
//           
//           let command = AsyncConnectCommand()
//           let arguments = ["url",
//                            "ws://localhost:8080/test",
//                            ]
//           
//           let console = TestConsole()
//           let input = CommandInput(arguments: arguments)
//           var context = CommandContext(
//               console: console,
//               input: input
//           )
//           context.application = app
//           
//           try console.run(command, with: context)
//
//           let output = console
//               .testOutputQueue
//               .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
//           
//           let expectation = [
//               "<test> false true nil nil"
//           ]
//        var s = ""
//        for line in output {
//            s.append(line)
//        }
//        
//        XCTAssertContains(s, expectation.first!)
//       }
//
//    func testAsyncConnectCommand_conects_with_cmwb15() async throws {
//        
//           let app = Application(.testing)
//           defer { app.shutdown() }
//           try await configure(app)
//           
//           let command = AsyncConnectCommand()
//           let arguments = ["url",
//                            "--client_max_window_bits=15",
//                            "ws://localhost:8080/test",
//                            ]
//           
//           let console = TestConsole()
//           let input = CommandInput(arguments: arguments)
//           var context = CommandContext(
//               console: console,
//               input: input
//           )
//           context.application = app
//           
//           try console.run(command, with: context)
//
//           let output = console
//               .testOutputQueue
//               .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
//           
//           let expectation = [
//               "<test> false true nil nil"
//           ]
//        var s = ""
//        for line in output {
//            s.append(line)
//        }
//        
//        XCTAssertContains(s, expectation.first!)
//       }
//
//}
