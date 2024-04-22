//
//  TimeClient.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-19.
//

import Foundation

final class TimeClient {
    let apiKey = "BEA50D34C57C5470DF3B475BD32C19FD822170E51060FF9107129DA61DA84526"

    func fetchReportedTime(fromDate: Date, toDate: Date) async throws -> [TimeEntry] {
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
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-ApiKey")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        let dateInformation = try decoder.decode([TimeEntry].self, from: data)
        return dateInformation
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

