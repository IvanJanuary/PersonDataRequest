//
//  ApiHelper.swift
//  PersonDataRequest
//
//  Created by Ivan on 13.02.2024.
//

import Foundation
import UIKit

struct ApiHelper {
    
    func makeRequest<T: Decodable>(urlString: String, t: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Gender request error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Decoding error JSON age: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func makePictureRequest(pictureUrl: String, index i: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: pictureUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return }
                       
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Gender request error: \(error.localizedDescription)")
                completion(.failure(error))
                return
        }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return }
            
            completion(.success(data))
        }
            
        task.resume()
    }
}
