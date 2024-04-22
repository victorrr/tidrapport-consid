//
//  TimeClient.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-19.
//

import Foundation

final class TimeClient {
    let apiKey = "BEA50D34C57C5470DF3B475BD32C19FD822170E51060FF9107129DA61DA84526"

    func fetchReportedTime(fromDate: Date, toDate: Date, completion: @escaping (Result<[TimeEntry], Error>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedFromDate = dateFormatter.string(from: fromDate)
        let formattedToDate = dateFormatter.string(from: toDate)
        var components = URLComponents(string: "https://tidig.consid.net/Api/Time")!
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "fromDate", value: formattedFromDate),
            URLQueryItem(name: "toDate", value: formattedToDate)
        ]

        guard let url = components.url else {
            // Hantera fel här om URL inte kan skapas
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(TimeClientError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let dateInformation = try decoder.decode([TimeEntry].self, from: data)
                completion(.success(dateInformation))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

// MARK: - DateInformation

struct DateInformation: Decodable {
    let empId: String
    let fromDate: String
    let toDate: String
    let customerId: String
    let customerName: String
    let projectId: String
    let projectName: String
}

// MARK: - TimeClientError

extension TimeClient {

    enum TimeClientError: Error {
        case noData
    }
}

