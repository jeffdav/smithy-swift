// Code generated by smithy-swift-codegen. DO NOT EDIT!

import ClientRuntime

extension WeatherClientTypes {
    public enum Precipitation: Swift.Equatable {
        case rain(Swift.Bool)
        case sleet(Swift.Bool)
        case hail([Swift.String:Swift.String])
        case snow(WeatherClientTypes.SimpleYesNo)
        case mixed(WeatherClientTypes.TypedYesNo)
        case other(WeatherClientTypes.OtherStructure)
        case blob(ClientRuntime.Data)
        case foo(WeatherClientTypes.Foo)
        case baz(WeatherClientTypes.Baz)
        case sdkUnknown(Swift.String)
    }

}
