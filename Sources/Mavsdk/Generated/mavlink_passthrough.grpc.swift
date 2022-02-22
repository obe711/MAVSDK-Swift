//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: mavlink_passthrough.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Usage: instantiate `Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughClient`, then call methods of this protocol to make API calls.
internal protocol Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughClientInterceptorFactoryProtocol? { get }

  func sendCommandLong(
    _ request: Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongRequest, Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongResponse>
}

extension Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughClientProtocol {
  internal var serviceName: String {
    return "mavsdk.rpc.mavlink_passthrough.MavlinkPassthrough"
  }

  ///
  /// Send command long drone.
  ///
  /// Arming a drone normally causes motors to spin at idle.
  /// Before arming take all safety precautions and stand clear of the drone!
  ///
  /// - Parameters:
  ///   - request: Request to send to SendCommandLong.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func sendCommandLong(
    _ request: Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongRequest, Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongResponse> {
    return self.makeUnaryCall(
      path: "/mavsdk.rpc.mavlink_passthrough.MavlinkPassthrough/SendCommandLong",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSendCommandLongInterceptors() ?? []
    )
  }
}

internal protocol Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'sendCommandLong'.
  func makeSendCommandLongInterceptors() -> [ClientInterceptor<Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongRequest, Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongResponse>]
}

internal final class Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughClient: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughClientInterceptorFactoryProtocol?

  /// Creates a client for the mavsdk.rpc.mavlink_passthrough.MavlinkPassthrough service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughProvider: CallHandlerProvider {
  var interceptors: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughServerInterceptorFactoryProtocol? { get }

  ///
  /// Send command long drone.
  ///
  /// Arming a drone normally causes motors to spin at idle.
  /// Before arming take all safety precautions and stand clear of the drone!
  func sendCommandLong(request: Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongResponse>
}

extension Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughProvider {
  internal var serviceName: Substring { return "mavsdk.rpc.mavlink_passthrough.MavlinkPassthrough" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "SendCommandLong":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongRequest>(),
        responseSerializer: ProtobufSerializer<Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongResponse>(),
        interceptors: self.interceptors?.makeSendCommandLongInterceptors() ?? [],
        userFunction: self.sendCommandLong(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'sendCommandLong'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeSendCommandLongInterceptors() -> [ServerInterceptor<Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongRequest, Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongResponse>]
}
