//
//  MyFileManagerTests.swift
//  MoviesTests
//
//  Created by Fan Wu on 6/2/23.
//

import XCTest
@testable import Movies

final class MyFileManagerTests: XCTestCase {
    let fileManager = MyFileManager.shared
    
    func testSave_ShouldSaveFile() {
        // Arrange
        let fileName = "test.txt"
        let fileData = "Test data".data(using: .utf8)!
        
        // Execute
        fileManager.save(fileName, data: fileData)
        
        // Assert
        if let fileURL = fileManager.getFileURL(fileName) {
            if let savedData = try? Data(contentsOf: fileURL) {
                XCTAssertEqual(savedData, fileData)
            } else {
                XCTFail("Failed to read saved data from the file")
            }
            
            // Clean up
            try? FileManager.default.removeItem(at: fileURL)
        } else {
            XCTFail("Failed to retrieve file URL")
        }
    }
    
    func testGet_ExistingFile_ShouldReturnFileData() {
        // Arrange
        let fileName = "test.txt"
        let fileData = "Test data".data(using: .utf8)!
        
        // Execute
        fileManager.save(fileName, data: fileData)
        
        // Assert
        if let fileURL = fileManager.getFileURL(fileName) {
            if let savedData = fileManager.get(fileName) {
                XCTAssertEqual(savedData, fileData)
            } else {
                XCTFail("Failed to read saved data from the file")
            }
            
            // Clean up
            try? FileManager.default.removeItem(at: fileURL)
        } else {
            XCTFail("Failed to retrieve file URL")
        }
    }
    
    func testGet_NonExistingFile_ShouldReturnNil() {
        // Arrange
        let fileName = "nonexistent.txt"
        
        // Execute
        let retrievedData = fileManager.get(fileName)
        
        // Assert
        XCTAssertNil(retrievedData)
    }
}
