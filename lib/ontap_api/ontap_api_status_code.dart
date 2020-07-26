//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum OntapApiStatusCode {
  s200,
  s201,
  s202,
  s400,
  s401,
  s403,
  s404,
  s405,
  s409,
  s500,
}

extension OntapApiStatusCodeMembers on OntapApiStatusCode {
  int get code =>
      int.tryParse(toString().split('.')?.last?.substring(1) ?? '500');
  //
  String get name => const {
        OntapApiStatusCode.s200: 'OK',
        OntapApiStatusCode.s201: 'Created',
        OntapApiStatusCode.s202: 'Accepted',
        OntapApiStatusCode.s400: 'Bad Request',
        OntapApiStatusCode.s401: 'Unauthorized',
        OntapApiStatusCode.s403: 'Forbidden',
        OntapApiStatusCode.s404: 'Not Found',
        OntapApiStatusCode.s405: 'Method Not Allowed',
        OntapApiStatusCode.s409: 'Conflict',
        OntapApiStatusCode.s500: 'Internal Error',
      }[this];
  //
  String get description => const {
        OntapApiStatusCode.s200: 'request completed successfully',
        OntapApiStatusCode.s201: 'object created as requested',
        OntapApiStatusCode.s202:
            'job submitted, operation will be performed asynchronously',
        OntapApiStatusCode.s400: 'request could not be parsed',
        OntapApiStatusCode.s401: 'Login credentials incorrect',
        OntapApiStatusCode.s403: 'You are not authorized',
        OntapApiStatusCode.s404: 'resource not found',
        OntapApiStatusCode.s405: 'unsupported request method',
        OntapApiStatusCode.s409: 'required object(s) not ready',
        OntapApiStatusCode.s500: 'Another internal error has occurred',
      }[this];
  //
  static OntapApiStatusCode fromCode(int code) =>
      OntapApiStatusCode.values.firstWhere(
        (v) => v.code == code,
        orElse: () => OntapApiStatusCode.s500,
      );
}
