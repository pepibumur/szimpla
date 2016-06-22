import Foundation
import Quick
import Nimble

@testable import Szimpla

class SnapshotSaverSpec: QuickSpec {
    override func spec() {
        var subject: SnapshotSaver!
        var fileManager: FileManagerMock!
        var snapshotToDataAdapter: SnapshotToDataAdapterMock!
        var snapshot: Snapshot!
        var data: (name: String, snapshot: Snapshot)!
        
        beforeEach {
            snapshot = Snapshot(requests: [])
            data = (name: "test", snapshot: snapshot)
        }
        
        describe("save:input:") {
            // TODO
//            context("when the adaptation fails") {
//                it("should return an error") {
//                    snapshotToDataAdapter = SnapshotToDataAdapterMock(shouldError: true)
//                    fileManager = FileManagerMock(shouldError: false)
//                    subject = SnapshotSaver(fileManager: fileManager, snapshotToDataAdapter: snapshotToDataAdapter)
//                }
//            }
//            context("when the file manager fails saving") {
//                
//            }
//            context("when the file manager succeed") {
//                
//            }
        }
    }
}


// MARK: - Private Mocks

private class FileManagerMock: FileManager {
    private let shouldError: Bool
    init(shouldError: Bool) {
        self.shouldError = shouldError
        super.init(basePath: NSURL(fileURLWithPath: "/"))
    }
    private override func save(data data: NSData, path: String) throws {
        if shouldError {
            throw MockError()
        }
    }
}

private class SnapshotToDataAdapterMock: SnapshotToDataAdapter {
    private let shouldError: Bool
    init(shouldError: Bool) {
        self.shouldError = shouldError
    }
    private override func adapt(input: Snapshot) -> Result<NSData, SnapshotToDataError>! {
        if shouldError {
            return Result.Error(SnapshotToDataError.SerializationError(MockError()))
        }
        else {
            return Result.Success(NSData())
        }
    }
}

private struct MockError: ErrorType {}