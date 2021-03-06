//
//  NetworkWorker.swift
//  RedditClient
//
//  Created by Ilya Borisov on 08.11.2020.
//

import UIKit

class NetworkWorker: NSObject {

    // MARK: - Constants
    //
    private let defaultSession = URLSession(configuration: .default)
    
    // MARK: - Private Properties
    //
    private weak var interactor: EntriesInteractor?
    private var dataTask: URLSessionDataTask?
    private var parsedEntries: [Entry]?
    private var nextSliceAnchorItem: String?
    
    // MARK: - Type Alias
    //
    typealias JSONDictionary = [String: Any]
    typealias ParsedResponse = ([Entry]?, String?) -> Void
    
    // MARK: - Life cycle
    //
    init(withInteractor interactor: EntriesInteractor) {
        
        self.interactor = interactor
    }
    
    // MARK: - Public Methods
    //
    func performGetRequest(withURLString urlString: String, completion: @escaping ParsedResponse) {
        
        dataTask?.cancel()
        
        guard let url = URL(string: urlString) else {
            print("Error creating URL with ", urlString)
            return
        }
        
        dataTask = defaultSession.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                print("Error ", error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                self?.parseResponse(withData: data)
                
                DispatchQueue.main.async {
                    completion(self?.parsedEntries, self?.nextSliceAnchorItem)
                }
            }
        })
        
        dataTask?.resume()
    }
    
    // MARK: - Private Methods
    //
    private func parseResponse(withData data: Data) {
        var response: JSONDictionary?
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print("JSONSerialization error: \(parseError.localizedDescription)")
            return
        }
        
        // Obtained JSONDictionary; Parsing it
        parsedEntries = []
        nextSliceAnchorItem = nil
        
        guard let responseData = response!["data"] as? JSONDictionary else {
            print("Dictionary does not contain <data> key")
            return
        }
        
        guard let entriesData = responseData["children"] as? [Any] else {
            print("data does not contain <children> array")
            return
        }
        
        for entryData in entriesData {
            guard let entryData = entryData as? JSONDictionary,
               let entryDictionary = entryData["data"] as? JSONDictionary,
               let title = entryDictionary["title"] as? String,
               let author = entryDictionary["author"] as? String,
               let commentsCount = entryDictionary["num_comments"] as? Int else {
                
                print("Problem parsing entryDictionary")
                continue
            }
            
            let created_utc_timestamp = entryDictionary["created_utc"] as? Int
            let thumbnailUrl = entryDictionary["thumbnail"] as? String
            let pictureUrl = entryDictionary["url_overridden_by_dest"] as? String
            
            parsedEntries?.append(Entry(withTitle: title, author: author, created_utc_timestamp: created_utc_timestamp, commentsCount: commentsCount, thumbnailUrl: thumbnailUrl, pictureUrl: pictureUrl))
        }
        
        guard let afterItem = responseData["after"] as? String else {
            print("data does not contain <after> key")
            return
        }
        
        nextSliceAnchorItem = afterItem
    }
    
}
