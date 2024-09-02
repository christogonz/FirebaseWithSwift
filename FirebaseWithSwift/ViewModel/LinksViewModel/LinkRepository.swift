//
//  LinkRepository.swift
//  FirebaseWithSwift
//
//  Created by Christopher Gonzalez on 2024-08-26.
//

import Foundation


final class LinkRepository {
    private let linkDataSource: LinkDataSource
    private let metadataDataSource: MetadataDataSource
    
    init(linkDataSource: LinkDataSource = LinkDataSource(),
         metadataDataSource: MetadataDataSource = MetadataDataSource()) {
        self.linkDataSource = linkDataSource
        self.metadataDataSource = metadataDataSource
    }
    
    
    //MARK: Get all Links from LinksDataSource
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void) {
        linkDataSource.getAllLinks(completionBlock: completionBlock)
    }
    
    //MARK: function to Create a new links object
    func createNewLink(withURL url: String, completionBlock: @escaping (Result<LinkModel, Error>) -> Void) {
//        metadataDataSource.getMetadata(fromURL: url,
//                                       completionBlock: completionBlock)
        
        metadataDataSource.getMetadata(fromURL: url) { [weak self] result in
            switch result {
            case .success(let linkModel):
                self?.linkDataSource.createNew(link: linkModel,
                                               completionBlock: completionBlock)
            case .failure(let error):
                completionBlock(.failure(error))
            }
            
        }
    }
}
