//
//  API Helper.swift
//  FoodDeliveryApp
//
//  Created by Zeel Shah on 17/08/25.
//

import Foundation

class APICalls {
    /**
     Generic API method to fetch data from a provided URL and decode it into an array of a codable model.
     
     - Parameters:
        - urlString: The API endpoint URL in `String` format.
        - completion: A closure that returns an array of decoded objects of type `[T]`.
     
     - Note:
        - This method performs a `GET` request using `URLSession`.
        - It handles:
            - Invalid URL errors
            - Network errors
            - Empty response handling
            - JSON decoding errors
        - The response is always returned to the `completion` handler as an array.
     
     - Usage Example:
     ```swift
     APICalls.getData(from: "https://api.example.com/items") { (items: [ItemModel]) in
         print(items)
     }
     ```
     */
    class func getData<T: Codable>(from urlString: String, completion: @escaping ([T]) -> Void) {
        // Ensure the provided string can form a valid URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL:", urlString)
            completion([])
            return
        }
        
        // Create a URL request with GET method
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // Perform network request using URLSession
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // Handle network-level error (e.g., no internet, timeout)
            if let error = error {
                print("Network error:", error)
                completion([])
                return
            }
            
            // Ensure response contains data
            guard let data = data else {
                print("Empty response data")
                completion([])
                return
            }
            
            // Attempt to decode data into the provided generic type
            do {
                let decoded = try JSONDecoder().decode([T].self, from: data)
                completion(decoded)
            } catch {
                // Handle JSON decoding issues
                print("Decoding error:", error)
                completion([])
            }
        }
        
        // Start the network request
        task.resume()
    }
}
