//
//  StorageManager.swift
//  Everent
//
//  Created by Tomas D. De Andrade Gomes on 2/7/24.
//

import Foundation
import FirebaseStorage
import SDWebImage

public class StorageManager {
    
    static let shared = StorageManager()
    
    let metadata = StorageMetadata()
    
    private init() {}
    
    private let bucket = Storage.storage().reference()
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    
    public enum StorageManagerError: Error {
        case failedToDownload
    }
    
    // MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    /// Uploads picture to firebase storage and returns completion with url string to download`
    public func uploadProfilePicture(with data: Data, fileName: String, completion: @escaping UploadPictureCompletion) {
        bucket.child("images/\(fileName)").putData(data, metadata: nil, completion: { [weak self] metadata, error in
           
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                //Failed
                print( "Failed to upload data to firebase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }

            strongSelf.bucket.child("images/\(fileName)").downloadURL(completion: { url, error in
                guard let url = url else {
                    print("Failed to get download url")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, StorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
    
    public func downloadUrl(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = bucket.child(path)
        
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            completion(.success(url))
        })
    }
}

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}
