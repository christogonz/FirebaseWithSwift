//
//  MetadataDataSource.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-27.
//

// MARK: Esto es para sacar los datos (metadata)
// MARK: de los link que guardemos como por ejemplo el titulo!

import Foundation
import LinkPresentation

enum CustomMetadaError: Error {
    case badURL
}

final class MetadataDataSource {
    private var metadataProvider: LPMetadataProvider?
    
    func getMetadata(fromURL url: String, completionBlock: @escaping (Result<LinkModel, Error>) -> Void) {
        
        guard let url = URL(string: url)  else {
            completionBlock(.failure(CustomMetadaError.badURL))
            return
        }
        metadataProvider = LPMetadataProvider()
        metadataProvider?.startFetchingMetadata(for: url, completionHandler: { metadata, error in
            if let error = error {
                print("Error getting metadata \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let linkModel = LinkModel(url: url.absoluteString,
                                      title: metadata?.title ?? "No Title",
                                      isFavorited: false,
                                      isCompleted: false
            )
            completionBlock(.success(linkModel))
        })
    }
}
