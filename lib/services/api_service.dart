// import 'dart:ffi';

// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../models/customer.dart';

// class ApiService {
//   static const String _baseUrl = "YOUR_API_BASE_URL";
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();
//   late Dio _dio;

//   ApiService() {
//     _dio = Dio(BaseOptions(
//       baseUrl: _baseUrl,
//       receiveTimeout: const Duration(seconds: 15),
//       connectTimeout: const Duration(seconds: 15),
//     ));
//     _setupInterceptors();
//   }

//   void _setupInterceptors() {
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           final token = await _storage.read(key: 'auth_token');
//           if (token != null) {
//             options.headers['Authorization'] = 'Bearer $token';
//           }
//           return handler.next(options);
//         },
//         onError: (error, handler) async {
//           if (error.response?.statusCode == 401) {
//             final refreshToken = await _storage.read(key: 'refresh_token');
//             if (refreshToken != null) {
//               try {
//                 final response = await _refreshToken(refreshToken);
//                 if (response != null) {
//                   final opts = Options(
//                     method: error.requestOptions.method,
//                     headers: error.requestOptions.headers,
//                   );
//                   opts.headers?['Authorization'] =
//                       'Bearer ${response['token']}';

//                   final clonedRequest = await _dio.request(
//                     error.requestOptions.path,
//                     options: opts,
//                     data: error.requestOptions.data,
//                     queryParameters: error.requestOptions.queryParameters,
//                   );

//                   return handler.resolve(clonedRequest);
//                 }
//               } catch (e) {
//                 await logout();
//                 return handler.reject(error);
//               }
//             }
//           }
//           return handler.next(error);
//         },
//       ),
//     );
//   }

//   Future<Map<String, dynamic>?> _refreshToken(String refreshToken) async {
//     try {
//       final response = await Dio(BaseOptions(baseUrl: _baseUrl)).post(
//         '/customer/refresh-token',
//         options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
//       );

//       if (response.statusCode == 200) {
//         final newToken = response.data['token'];
//         final newRefreshToken = response.data['refresh_token'];

//         await _storage.write(key: 'auth_token', value: newToken);
//         await _storage.write(key: 'refresh_token', value: newRefreshToken);

//         return {
//           'token': newToken,
//           'refresh_token': newRefreshToken,
//         };
//       }
//       return null;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<Bool> login(String email, String password) async {
//     try {
//       final response = await _dio.post('/customer/login', data: {
//         'email': email,
//         'password': password,
//       });

//       if (response.statusCode == 200) {
//         final data = response.data;
//         await _storeTokens(data);
//         return true;
//       }
//       throw Exception(response.data['msg'] ?? 'Login failed');
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['msg'] ?? 'Login failed');
//     }
//   }

//   Future<Bool> register({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String password,
//     required String phone,
//     String? birthDate,
//     String? gender,
//     String? photo,
//   }) async {
//     try {
//       final formData = FormData.fromMap({
//         'first_name': firstName,
//         'last_name': lastName,
//         'email': email,
//         'password': password,
//         'phone': phone,
//         if (birthDate != null) 'birth_date': birthDate,
//         if (gender != null) 'gender': gender,
//         if (photo != null) 'photo': await MultipartFile.fromFile(photo),
//       });

//       final response = await _dio.post('/customer/register', data: formData);

//       if (response.statusCode == 201) {
//         final data = response.data;
//         await _storeTokens(data);
//         return true;
//       }
//       throw Exception(response.data['msg'] ?? 'Registration failed');
//     } on DioException catch (e) {
//       throw Exception(e.response?.data['msg'] ?? 'Registration failed');
//     }
//   }

//   Future<void> _storeTokens(Map<String, dynamic> data) async {
//     if (data['token'] != null) {
//       await _storage.write(key: 'auth_token', value: data['token']);
//     }
//     if (data['refresh_token'] != null) {
//       await _storage.write(key: 'refresh_token', value: data['refresh_token']);
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await _dio.post('/customer/logout');
//       await _storage.delete(key: 'auth_token');
//       await _storage.delete(key: 'refresh_token');
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Customer> fetchCustomerInfo() async {
//     try {
//       final response = await _dio.get('/customer/info');
//       if (response.statusCode == 200) {
//         return Customer.fromJson(response.data['data']);
//       }
//       throw Exception(response.data['msg'] ?? 'Failed to fetch customer info');
//     } on DioException catch (e) {
//       throw Exception(
//           e.response?.data['msg'] ?? 'Failed to fetch customer info');
//     }
//   }
// }
