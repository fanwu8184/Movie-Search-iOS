//
//  MyFileManager.swift
//  Movies
//
//  Created by Fan Wu on 6/1/23.
//

import Foundation

class MyFileManager {
    static let shared = MyFileManager()
    
    func getFileURL(_ fileName: String) -> URL? {
        if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            return cacheDirectory.appendingPathComponent(fileName)
        }
        return nil
    }
    
    func save(_ fileName: String, data: Data) {
        if let fileURL = getFileURL(fileName) {
            if FileManager.default.fileExists(atPath: fileURL.path()) {
                do {
                    try FileManager.default.removeItem(at: fileURL)
                } catch {
                    print("Failed to remove file: \(error.localizedDescription)")
                }
            }
            else {
                do {
                    try data.write(to: fileURL)
                } catch {
                    print("Failed to save file: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func get(_ fileName: String) -> Data? {
        if let fileURL = getFileURL(fileName) {
            return try? Data(contentsOf: fileURL)
        }
        return nil
    }
}
