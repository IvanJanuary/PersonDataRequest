//
//  ApiHelper.swift
//  PersonDataRequest
//
//  Created by Ivan on 13.02.2024.
//

import Foundation

struct ApiHelper {
    
    func makeRequest<T: Decodable>(urlString: String, t: T.Type, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Gender request error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return }
            
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData)
            } catch {
                print("Decoding error JSON age: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
