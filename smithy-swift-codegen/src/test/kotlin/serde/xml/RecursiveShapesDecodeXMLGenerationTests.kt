package serde.xml

import MockHttpRestXMLProtocolGenerator
import TestContext
import defaultSettings
import getFileContents
import io.kotest.matchers.string.shouldContainOnlyOnce
import org.junit.jupiter.api.Test

class RecursiveShapesDecodeXMLGenerationTests {
    @Test
    fun `decode recursive shape`() {
        val context = setupTests("Isolated/Restxml/xml-recursive.smithy", "aws.protocoltests.restxml#RestXml")
        val contents = getFileContents(context.manifest, "/RestXml/models/XmlRecursiveShapesOutputResponseBody+Extensions.swift")
        val expectedContents =
            """
            extension XmlRecursiveShapesOutputResponseBody: Decodable {
                enum CodingKeys: String, CodingKey {
                    case nested
                }
            
                public init (from decoder: Decoder) throws {
                    let containerValues = try decoder.container(keyedBy: CodingKeys.self)
                    let nestedDecoded = try containerValues.decodeIfPresent(RecursiveShapesInputOutputNested1.self, forKey: .nested)
                    nested = nestedDecoded
                }
            }
            """.trimIndent()
        contents.shouldContainOnlyOnce(expectedContents)
    }

    @Test
    fun `decode recursive nested shape`() {
        val context = setupTests("Isolated/Restxml/xml-recursive-nested.smithy", "aws.protocoltests.restxml#RestXml")
        val contents = getFileContents(context.manifest, "/RestXml/models/XmlNestedRecursiveShapesOutputResponseBody+Extensions.swift")
        val expectedContents =
            """
            extension XmlNestedRecursiveShapesOutputResponseBody: Decodable {
                enum CodingKeys: String, CodingKey {
                    case nestedRecursiveList
                }
            
                public init (from decoder: Decoder) throws {
                    let containerValues = try decoder.container(keyedBy: CodingKeys.self)
                    if containerValues.contains(.nestedRecursiveList) {
                        struct KeyVal0{struct member{}}
                        let nestedRecursiveListWrappedContainer = containerValues.nestedContainerNonThrowable(keyedBy: CollectionMemberCodingKey<KeyVal0.member>.CodingKeys.self, forKey: .nestedRecursiveList)
                        if let nestedRecursiveListWrappedContainer = nestedRecursiveListWrappedContainer {
                            let nestedRecursiveListContainer = try nestedRecursiveListWrappedContainer.decodeIfPresent([[RecursiveShapesInputOutputNested1]].self, forKey: .member)
                            var nestedRecursiveListBuffer:[[RecursiveShapesInputOutputNested1]]? = nil
                            if let nestedRecursiveListContainer = nestedRecursiveListContainer {
                                nestedRecursiveListBuffer = [[RecursiveShapesInputOutputNested1]]()
                                var listBuffer0: [RecursiveShapesInputOutputNested1]? = nil
                                for listContainer0 in nestedRecursiveListContainer {
                                    listBuffer0 = [RecursiveShapesInputOutputNested1]()
                                    for structureContainer1 in listContainer0 {
                                        listBuffer0?.append(structureContainer1)
                                    }
                                    if let listBuffer0 = listBuffer0 {
                                        nestedRecursiveListBuffer?.append(listBuffer0)
                                    }
                                }
                            }
                            nestedRecursiveList = nestedRecursiveListBuffer
                        } else {
                            nestedRecursiveList = []
                        }
                    } else {
                        nestedRecursiveList = nil
                    }
                }
            }
            """.trimIndent()

        contents.shouldContainOnlyOnce(expectedContents)
    }

    private fun setupTests(smithyFile: String, serviceShapeId: String): TestContext {
        val context = TestContext.initContextFrom(smithyFile, serviceShapeId, MockHttpRestXMLProtocolGenerator()) { model ->
            model.defaultSettings(serviceShapeId, "RestXml", "2019-12-16", "Rest Xml Protocol")
        }
        context.generator.generateDeserializers(context.generationCtx)
        context.generationCtx.delegator.flushWriters()
        return context
    }
}
