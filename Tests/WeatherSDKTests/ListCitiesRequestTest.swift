// Code generated by smithy-swift-codegen. DO NOT EDIT!

import ClientRuntime
import SmithyTestUtil
@testable import WeatherSDK
import XCTest


class ListCitiesRequestTest: HttpRequestTestBase {
    /// Does something
    func testWriteListCitiesAssertions() async throws {
        let urlPrefix = urlPrefixFromHost(host: "")
        let hostOnly = hostOnlyFromHost(host: "")
        let expected = buildExpectedHttpRequest(
            method: .get,
            path: "/cities",
            queryParams: [
                "pageSize=50"
            ],
            forbiddenQueryParams: [
                "nextToken"
            ],
            body: nil,
            host: "",
            resolvedHost: ""
        )

        let decoder = ClientRuntime.JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "Infinity", negativeInfinity: "-Infinity", nan: "NaN")

        let input = ListCitiesInput(
            pageSize: 50
        )
        let encoder = ClientRuntime.JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        encoder.nonConformingFloatEncodingStrategy = .convertToString(positiveInfinity: "Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        let context = HttpContextBuilder()
                      .withEncoder(value: encoder)
                      .withMethod(value: .get)
                      .build()
        var operationStack = OperationStack<ListCitiesInput, ListCitiesOutput>(id: "WriteListCitiesAssertions")
        operationStack.initializeStep.intercept(position: .after, middleware: ClientRuntime.URLPathMiddleware<ListCitiesInput, ListCitiesOutput>(urlPrefix: urlPrefix, ListCitiesInput.urlPathProvider(_:)))
        operationStack.initializeStep.intercept(position: .after, middleware: ClientRuntime.URLHostMiddleware<ListCitiesInput, ListCitiesOutput>(host: hostOnly))
        operationStack.buildStep.intercept(position: .after, id: "RequestTestEndpointResolver") { (context, input, next) -> ClientRuntime.OperationOutput<ListCitiesOutput> in
            input.withMethod(context.getMethod())
            input.withPath(context.getPath())
            let host = "\(context.getHostPrefix() ?? "")\(context.getHost() ?? "")"
            input.withHost(host)
            return try await next.handle(context: context, input: input)
        }
        operationStack.serializeStep.intercept(position: .after, middleware: ClientRuntime.QueryItemMiddleware<ListCitiesInput, ListCitiesOutput>(ListCitiesInput.queryItemProvider(_:)))
        operationStack.deserializeStep.intercept(
            position: .after,
            middleware: MockDeserializeMiddleware<ListCitiesOutput>(
                id: "TestDeserializeMiddleware",
                responseClosure: responseClosure(decoder: decoder),
                callback: { context, actual in
                    try await self.assertEqual(expected, actual)
                    return OperationOutput(httpResponse: HttpResponse(body: ByteStream.noStream, statusCode: .ok), output: ListCitiesOutput())
                }
            )
        )
        _ = try await operationStack.handleMiddleware(context: context, input: input, next: MockHandler() { (context, request) in
            XCTFail("Deserialize was mocked out, this should fail")
            throw SmithyTestUtilError("Mock handler unexpectedly failed")
        })
    }
}
