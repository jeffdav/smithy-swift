// Code generated by smithy-swift-codegen. DO NOT EDIT!

import ClientRuntime

struct InvokeInputBody: Swift.Equatable {
    let payload: ClientRuntime.Data?
}

extension InvokeInputBody: Swift.Decodable {
    enum CodingKeys: Swift.String, Swift.CodingKey {
        case payload
    }

    public init(from decoder: Swift.Decoder) throws {
        let containerValues = try decoder.container(keyedBy: CodingKeys.self)
        let payloadDecoded = try containerValues.decodeIfPresent(ClientRuntime.Data.self, forKey: .payload)
        payload = payloadDecoded
    }
}
