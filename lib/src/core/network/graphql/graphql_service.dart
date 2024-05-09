import 'dart:developer';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../data/api_response.dart';
import '../../../features/login/data/datasources/network/exceptions/api_exception.dart';

@singleton
class GraphQLService {
  GraphQLService() {
    final link = HttpLink('https://unswipe-backend-production.up.railway.app/graphql');
    _graphQLClient = GraphQLClient(link: link, cache: GraphQLCache());
  }

  late final GraphQLClient _graphQLClient;

  Future<ApiResponse<dynamic>> performQuery(
    String query, {
    required Map<String, dynamic> variables,
  }) async {
    try {
      final options = QueryOptions(
        document: gql(query),
        variables: variables,
      );

      final result = await _graphQLClient.query(options);

      if (result.hasException) {
        final errorCode =
            result.context.entry<HttpLinkResponseContext>()?.statusCode ?? 0;
        return Failure(
          error: APIException(result.exception.toString(), errorCode, ''),
        );
      } else {
        return Success(data: result.data);
      }
    } on Exception catch (_, e) {
      return Failure(error: APIException(e.toString(), 0, ''));
    }
  }

  Future<QueryResult> performMutation(
    String query,
      {
    required Map<String, dynamic> variables,
  }) async {
    final options = MutationOptions(document: gql(query), variables: variables);

    final result = await _graphQLClient.mutate(options);

    log(result.toString());

    return result;
  }

  Future<QueryResult> performMutationWithHeader(
      String token,
      String query,
      {
        required Map<String, dynamic> variables,
      }) async {
    final options = MutationOptions(document: gql(query), variables: variables);
     var link =  HttpLink('https://unswipe-backend-production.up.railway.app/graphql',
        defaultHeaders: {
          'Content-Type': 'application/json',
          'Accept-Charset': 'utf-8',
          'Authorization': 'Bearer $token',
        });
    final result = await GraphQLClient(link: link, cache: GraphQLCache()).mutate(options);

    log(result.toString());

    return result;
  }


}
