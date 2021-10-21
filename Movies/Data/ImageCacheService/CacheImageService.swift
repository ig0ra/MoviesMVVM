// CacheImageService.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

protocol CacheImageServiceProtocol {
    func saveImage(url: String, imageData: Data)
    func getImage(url: String) -> Data?
}

final class CacheImageService: CacheImageServiceProtocol {
    // MARK: - Private properties

    private let fileManager = FileManager.default

    private lazy var filePath: String = {
        let pathName = "images"
        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return pathName }
        let url = cacheDirectory.appendingPathComponent(pathName, isDirectory: true)

        if !fileManager.fileExists(atPath: url.path) {
            try? fileManager.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }

        return pathName
    }()

    // MARK: - Private methods

    private func getFilePath(url: String) -> String? {
        guard let cachedDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return nil }
        let imageHash = url.split(separator: "/").last ?? "default"
        return cachedDirectory.appendingPathComponent(filePath + "/" + imageHash).path
    }

    // MARK: - CacheImageServiceProtocol

    func saveImage(url: String, imageData: Data) {
        guard let fileName = getFilePath(url: url) else { return }
        fileManager.createFile(atPath: fileName, contents: imageData, attributes: nil)
    }

    func getImage(url: String) -> Data? {
        guard let fileName = getFilePath(url: url) else { return nil }
        return UIImage(contentsOfFile: fileName)?.pngData()
    }
}
