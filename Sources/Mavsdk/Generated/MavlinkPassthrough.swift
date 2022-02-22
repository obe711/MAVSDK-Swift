import Foundation
import RxSwift
import GRPC
import NIO

/**
 
 */
public class MavlinkPassthrough {
    private let service: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughServiceClient
    private let scheduler: SchedulerType
    private let clientEventLoopGroup: EventLoopGroup

    /**
     Initializes a new `MavlinkPassthrough` plugin.

     Normally never created manually, but used from the `Drone` helper class instead.

     - Parameters:
        - address: The address of the `MavsdkServer` instance to connect to
        - port: The port of the `MavsdkServer` instance to connect to
        - scheduler: The scheduler to be used by `Observable`s
     */
    public convenience init(address: String = "localhost",
                            port: Int32 = 50051,
                            scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)) {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 2)
        let channel = ClientConnection.insecure(group: eventLoopGroup).connect(host: address, port: Int(port))
        let service = Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughServiceClient(channel: channel)

        self.init(service: service, scheduler: scheduler, eventLoopGroup: eventLoopGroup)
    }

    init(service: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughServiceClient, scheduler: SchedulerType, eventLoopGroup: EventLoopGroup) {
        self.service = service
        self.scheduler = scheduler
        self.clientEventLoopGroup = eventLoopGroup
    }

    public struct RuntimeMavlinkPassthroughError: Error {
        public let description: String

        init(_ description: String) {
            self.description = description
        }
    }

    
    public struct MavlinkPassthroughError: Error {
        public let code: MavlinkPassthrough.MavlinkPassthroughResult.Result
        public let description: String
    }
    


    /**
     Result type.
     */
    public struct MavlinkPassthroughResult: Equatable {
        public let result: Result
        public let resultStr: String

        
        

        /**
         Possible results returned for action requests.
         */
        public enum Result: Equatable {
            ///  Unknown result.
            case unknown
            ///  Request was successful.
            case success
            ///  Connection error.
            case connectionError
            ///  No system is connected.
            case commandNoSystem
            ///  Vehicle is busy.
            case commandBusy
            ///  Command refused by vehicle.
            case commandDenied
            /// .
            case commandUnsupported
            ///  Request timed out.
            case commandTimeout
            case UNRECOGNIZED(Int)

            internal var rpcResult: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughResult.Result {
                switch self {
                case .unknown:
                    return .unknown
                case .success:
                    return .success
                case .connectionError:
                    return .connectionError
                case .commandNoSystem:
                    return .commandNoSystem
                case .commandBusy:
                    return .commandBusy
                case .commandDenied:
                    return .commandDenied
                case .commandUnsupported:
                    return .commandUnsupported
                case .commandTimeout:
                    return .commandTimeout
                case .UNRECOGNIZED(let i):
                    return .UNRECOGNIZED(i)
                }
            }

            internal static func translateFromRpc(_ rpcResult: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughResult.Result) -> Result {
                switch rpcResult {
                case .unknown:
                    return .unknown
                case .success:
                    return .success
                case .connectionError:
                    return .connectionError
                case .commandNoSystem:
                    return .commandNoSystem
                case .commandBusy:
                    return .commandBusy
                case .commandDenied:
                    return .commandDenied
                case .commandUnsupported:
                    return .commandUnsupported
                case .commandTimeout:
                    return .commandTimeout
                case .UNRECOGNIZED(let i):
                    return .UNRECOGNIZED(i)
                }
            }
        }
        

        /**
         Initializes a new `MavlinkPassthroughResult`.

         
         - Parameters:
            
            - result:  Result enum value
            
            - resultStr:  Human-readable English string describing the result
            
         
         */
        public init(result: Result, resultStr: String) {
            self.result = result
            self.resultStr = resultStr
        }

        internal var rpcMavlinkPassthroughResult: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughResult {
            var rpcMavlinkPassthroughResult = Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughResult()
            
                
            rpcMavlinkPassthroughResult.result = result.rpcResult
                
            
            
                
            rpcMavlinkPassthroughResult.resultStr = resultStr
                
            

            return rpcMavlinkPassthroughResult
        }

        internal static func translateFromRpc(_ rpcMavlinkPassthroughResult: Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughResult) -> MavlinkPassthroughResult {
            return MavlinkPassthroughResult(result: Result.translateFromRpc(rpcMavlinkPassthroughResult.result), resultStr: rpcMavlinkPassthroughResult.resultStr)
        }

        public static func == (lhs: MavlinkPassthroughResult, rhs: MavlinkPassthroughResult) -> Bool {
            return lhs.result == rhs.result
                && lhs.resultStr == rhs.resultStr
        }
    }


    /**
     Send command long drone.

     Arming a drone normally causes motors to spin at idle.
     Before arming take all safety precautions and stand clear of the drone!

     - Parameters:
        - targetSysid:*< @brief System ID to send command to
        - targetCompid:*< @brief Component ID to send command to
        - command:*< @brief command to send.
        - param1:*< @brief param1.
        - param2:*< @brief param2.
        - param3:*< @brief param3.
        - param4:*< @brief param4.
        - param5:*< @brief param5.
        - param6:*< @brief param6.
        - param7:*< @brief param7.
     
     */
    public func sendCommandLong(targetSysid: UInt32, targetCompid: UInt32, command: UInt32, param1: Float, param2: Float, param3: Float, param4: Float, param5: Float, param6: Float, param7: Float) -> Completable {
        return Completable.create { completable in
            var request = Mavsdk_Rpc_MavlinkPassthrough_SendCommandLongRequest()

            
                
            request.targetSysid = targetSysid
                
            
                
            request.targetCompid = targetCompid
                
            
                
            request.command = command
                
            
                
            request.param1 = param1
                
            
                
            request.param2 = param2
                
            
                
            request.param3 = param3
                
            
                
            request.param4 = param4
                
            
                
            request.param5 = param5
                
            
                
            request.param6 = param6
                
            
                
            request.param7 = param7
                
            

            do {
                
                let response = self.service.sendCommandLong(request)

                let result = try response.response.wait().mavlinkPassthroughResult
                if (result.result == Mavsdk_Rpc_MavlinkPassthrough_MavlinkPassthroughResult.Result.success) {
                    completable(.completed)
                } else {
                    completable(.error(MavlinkPassthroughError(code: MavlinkPassthroughResult.Result.translateFromRpc(result.result), description: result.resultStr)))
                }
                
            } catch {
                completable(.error(error))
            }

            return Disposables.create()
        }
    }
}