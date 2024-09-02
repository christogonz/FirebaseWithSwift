//
//  LinksDataSource.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-26.
//

import Foundation
import FirebaseFirestore


// MARK: Model
struct LinkModel: Decodable, Identifiable, Encodable {
    @DocumentID var id: String?
    let url: String
    let title: String
    let isFavorited: Bool
    let isCompleted: Bool
}



final class LinkDataSource {
    private let database = Firestore.firestore()
    private let collection = "links"
    
    
    // MARK: [Get] Data from Firebase ("links" Collection)
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void) {
        // Get Data
        database.collection(collection)
            .addSnapshotListener { query, error in
                // Error Handler
                if let error = error {
                    print("Error getting all links \(error.localizedDescription)")
                    completionBlock(.failure(error))
                    return
                }
                // Succes Handler
                guard let documents = query?.documents.compactMap({$0}) else {
                    completionBlock(.success([]))
                    return
                }
                // Pone lo que trajo de firebase en mi LinkModel
                let links = documents.map { try? $0.data(as: LinkModel.self)}
                    .compactMap { $0 }
                
                completionBlock(.success(links))
            }
    }
    
    //MARK: [Create] new Link
    func createNew(link: LinkModel, completionBlock: @escaping (Result<LinkModel, Error>) -> Void) {
        
        do {
            _ = try database.collection(collection).addDocument(from: link)
            completionBlock(.success(link))
        } catch {
            completionBlock(.failure(error))
        }
    }
    
  
    //MARK: [Update] Link
    func update(link: LinkModel) {
        guard let documentId = link.id else {
            return
        }
        do {
            _ = try database.collection(collection).document(documentId).setData(from: link)
        } catch {
            print("Error updating link in our database")
        }
    }
    
    //MARK: [Detele] Link
    func detele(link: LinkModel) {
        guard let documentId = link.id else {
            return
        }
        database.collection(collection).document(documentId).delete()
    }
}
