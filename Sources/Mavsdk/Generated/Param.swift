import Foundation
import RxSwift
import GRPC
import NIO

/**
 Provide raw access to get and set parameters.
 */
public class Param {
    private let service: Mavsdk_Rpc_Param_ParamServiceClient
    private let scheduler: SchedulerType
    private let clientEventLoopGroup: EventLoopGroup

    /**
     Initializes a new `Param` plugin.

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
        let service = Mavsdk_Rpc_Param_ParamServiceClient(channel: channel)

        self.init(service: service, scheduler: scheduler, eventLoopGroup: eventLoopGroup)
    }

    init(service: Mavsdk_Rpc_Param_ParamServiceClient, scheduler: SchedulerType, eventLoopGroup: EventLoopGroup) {
        self.service = service
        self.scheduler = scheduler
        self.clientEventLoopGroup = eventLoopGroup
    }

    public struct RuntimeParamError: Error {
        public let description: String

        init(_ description: String) {
            self.description = description
        }
    }

    
    public struct ParamError: Error {
        public let code: Param.ParamResult.Result
        public let description: String
    }
    


    /**
     Type for integer parameters.
     */
    public struct IntParam: Equatable {
        public let name: String
        public let value: Int32

        

        /**
         Initializes a new `IntParam`.

         
         - Parameters:
            
            - name:  Name of the parameter
            
            - value:  Value of the parameter
            
         
         */
        public init(name: String, value: Int32) {
            self.name = name
            self.value = value
        }

        internal var rpcIntParam: Mavsdk_Rpc_Param_IntParam {
            var rpcIntParam = Mavsdk_Rpc_Param_IntParam()
            
                
            rpcIntParam.name = name
                
            
            
                
            rpcIntParam.value = value
                
            

            return rpcIntParam
        }

        internal static func translateFromRpc(_ rpcIntParam: Mavsdk_Rpc_Param_IntParam) -> IntParam {
            return IntParam(name: rpcIntParam.name, value: rpcIntParam.value)
        }

        public static func == (lhs: IntParam, rhs: IntParam) -> Bool {
            return lhs.name == rhs.name
                && lhs.value == rhs.value
        }
    }

    /**
     Type for float parameters.
     */
    public struct FloatParam: Equatable {
        public let name: String
        public let value: Float

        

        /**
         Initializes a new `FloatParam`.

         
         - Parameters:
            
            - name:  Name of the parameter
            
            - value:  Value of the parameter
            
         
         */
        public init(name: String, value: Float) {
            self.name = name
            self.value = value
        }

        internal var rpcFloatParam: Mavsdk_Rpc_Param_FloatParam {
            var rpcFloatParam = Mavsdk_Rpc_Param_FloatParam()
            
                
            rpcFloatParam.name = name
                
            
            
                
            rpcFloatParam.value = value
                
            

            return rpcFloatParam
        }

        internal static func translateFromRpc(_ rpcFloatParam: Mavsdk_Rpc_Param_FloatParam) -> FloatParam {
            return FloatParam(name: rpcFloatParam.name, value: rpcFloatParam.value)
        }

        public static func == (lhs: FloatParam, rhs: FloatParam) -> Bool {
            return lhs.name == rhs.name
                && lhs.value == rhs.value
        }
    }

    /**
     Type collecting all integer and float parameters.
     */
    public struct AllParams: Equatable {
        public let intParams: [IntParam]
        public let floatParams: [FloatParam]

        

        /**
         Initializes a new `AllParams`.

         
         - Parameters:
            
            - intParams:  Collection of all parameter names and values of type int
            
            - floatParams:  Collection of all parameter names and values of type float
            
         
         */
        public init(intParams: [IntParam], floatParams: [FloatParam]) {
            self.intParams = intParams
            self.floatParams = floatParams
        }

        internal var rpcAllParams: Mavsdk_Rpc_Param_AllParams {
            var rpcAllParams = Mavsdk_Rpc_Param_AllParams()
            
                
            rpcAllParams.intParams = intParams.map{ $0.rpcIntParam }
                
            
            
                
            rpcAllParams.floatParams = floatParams.map{ $0.rpcFloatParam }
                
            

            return rpcAllParams
        }

        internal static func translateFromRpc(_ rpcAllParams: Mavsdk_Rpc_Param_AllParams) -> AllParams {
            return AllParams(intParams: rpcAllParams.intParams.map{ IntParam.translateFromRpc($0) }, floatParams: rpcAllParams.floatParams.map{ FloatParam.translateFromRpc($0) })
        }

        public static func == (lhs: AllParams, rhs: AllParams) -> Bool {
            return lhs.intParams == rhs.intParams
                && lhs.floatParams == rhs.floatParams
        }
    }

    /**
     Result type.
     */
    public struct ParamResult: Equatable {
        public let result: Result
        public let resultStr: String

        
        

        /**
         Possible results returned for param requests.
         */
        public enum Result: Equatable {
            ///  Unknown result.
            case unknown
            ///  Request succeeded.
            case success
            ///  Request timed out.
            case timeout
            ///  Connection error.
            case connectionError
            ///  Wrong type.
            case wrongType
            ///  Parameter name too long (> 16).
            case paramNameTooLong
            ///  No system connected.
            case noSystem
            case UNRECOGNIZED(Int)

            internal var rpcResult: Mavsdk_Rpc_Param_ParamResult.Result {
                switch self {
                case .unknown:
                    return .unknown
                case .success:
                    return .success
                case .timeout:
                    return .timeout
                case .connectionError:
                    return .connectionError
                case .wrongType:
                    return .wrongType
                case .paramNameTooLong:
                    return .paramNameTooLong
                case .noSystem:
                    return .noSystem
                case .UNRECOGNIZED(let i):
                    return .UNRECOGNIZED(i)
                }
            }

            internal static func translateFromRpc(_ rpcResult: Mavsdk_Rpc_Param_ParamResult.Result) -> Result {
                switch rpcResult {
                case .unknown:
                    return .unknown
                case .success:
                    return .success
                case .timeout:
                    return .timeout
                case .connectionError:
                    return .connectionError
                case .wrongType:
                    return .wrongType
                case .paramNameTooLong:
                    return .paramNameTooLong
                case .noSystem:
                    return .noSystem
                case .UNRECOGNIZED(let i):
                    return .UNRECOGNIZED(i)
                }
            }
        }
        

        /**
         Initializes a new `ParamResult`.

         
         - Parameters:
            
            - result:  Result enum value
            
            - resultStr:  Human-readable English string describing the result
            
         
         */
        public init(result: Result, resultStr: String) {
            self.result = result
            self.resultStr = resultStr
        }

        internal var rpcParamResult: Mavsdk_Rpc_Param_ParamResult {
            var rpcParamResult = Mavsdk_Rpc_Param_ParamResult()
            
                
            rpcParamResult.result = result.rpcResult
                
            
            
                
            rpcParamResult.resultStr = resultStr
                
            

            return rpcParamResult
        }

        internal static func translateFromRpc(_ rpcParamResult: Mavsdk_Rpc_Param_ParamResult) -> ParamResult {
            return ParamResult(result: Result.translateFromRpc(rpcParamResult.result), resultStr: rpcParamResult.resultStr)
        }

        public static func == (lhs: ParamResult, rhs: ParamResult) -> Bool {
            return lhs.result == rhs.result
                && lhs.resultStr == rhs.resultStr
        }
    }


    /**
     Get an int parameter.

     If the type is wrong, the result will be `WRONG_TYPE`.

     - Parameter name: Name of the parameter
     
     */
    public func getParamInt(name: String) -> Single<Int32> {
        return Single<Int32>.create { single in
            var request = Mavsdk_Rpc_Param_GetParamIntRequest()

            
                
            request.name = name
                
            

            do {
                let response = self.service.getParamInt(request)

                
                let result = try response.response.wait().paramResult
                if (result.result != Mavsdk_Rpc_Param_ParamResult.Result.success) {
                    single(.failure(ParamError(code: ParamResult.Result.translateFromRpc(result.result), description: result.resultStr)))

                    return Disposables.create()
                }
                

    	    let value = try response.response.wait().value
                
                single(.success(value))
            } catch {
                single(.failure(error))
            }

            return Disposables.create()
        }
    }

    /**
     Set an int parameter.

     If the type is wrong, the result will be `WRONG_TYPE`.

     - Parameters:
        - name: Name of the parameter to set
        - value: Value the parameter should be set to
     
     */
    public func setParamInt(name: String, value: Int32) -> Completable {
        return Completable.create { completable in
            var request = Mavsdk_Rpc_Param_SetParamIntRequest()

            
                
            request.name = name
                
            
                
            request.value = value
                
            

            do {
                
                let response = self.service.setParamInt(request)

                let result = try response.response.wait().paramResult
                if (result.result == Mavsdk_Rpc_Param_ParamResult.Result.success) {
                    completable(.completed)
                } else {
                    completable(.error(ParamError(code: ParamResult.Result.translateFromRpc(result.result), description: result.resultStr)))
                }
                
            } catch {
                completable(.error(error))
            }

            return Disposables.create()
        }
    }

    /**
     Get a float parameter.

     If the type is wrong, the result will be `WRONG_TYPE`.

     - Parameter name: Name of the parameter
     
     */
    public func getParamFloat(name: String) -> Single<Float> {
        return Single<Float>.create { single in
            var request = Mavsdk_Rpc_Param_GetParamFloatRequest()

            
                
            request.name = name
                
            

            do {
                let response = self.service.getParamFloat(request)

                
                let result = try response.response.wait().paramResult
                if (result.result != Mavsdk_Rpc_Param_ParamResult.Result.success) {
                    single(.failure(ParamError(code: ParamResult.Result.translateFromRpc(result.result), description: result.resultStr)))

                    return Disposables.create()
                }
                

    	    let value = try response.response.wait().value
                
                single(.success(value))
            } catch {
                single(.failure(error))
            }

            return Disposables.create()
        }
    }

    /**
     Set a float parameter.

     If the type is wrong, the result will be `WRONG_TYPE`.

     - Parameters:
        - name: Name of the parameter to set
        - value: Value the parameter should be set to
     
     */
    public func setParamFloat(name: String, value: Float) -> Completable {
        return Completable.create { completable in
            var request = Mavsdk_Rpc_Param_SetParamFloatRequest()

            
                
            request.name = name
                
            
                
            request.value = value
                
            

            do {
                
                let response = self.service.setParamFloat(request)

                let result = try response.response.wait().paramResult
                if (result.result == Mavsdk_Rpc_Param_ParamResult.Result.success) {
                    completable(.completed)
                } else {
                    completable(.error(ParamError(code: ParamResult.Result.translateFromRpc(result.result), description: result.resultStr)))
                }
                
            } catch {
                completable(.error(error))
            }

            return Disposables.create()
        }
    }

    /**
     Get all parameters.

     
     */
    public func getAllParams() -> Single<AllParams> {
        return Single<AllParams>.create { single in
            let request = Mavsdk_Rpc_Param_GetAllParamsRequest()

            

            do {
                let response = self.service.getAllParams(request)

                

    	    
                    let params = try AllParams.translateFromRpc(response.response.wait().params)
                
                single(.success(params))
            } catch {
                single(.failure(error))
            }

            return Disposables.create()
        }
    }
}