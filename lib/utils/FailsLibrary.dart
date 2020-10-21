import 'package:covid19_tracker/models/Fails.dart';

// After modifying this library the app must be restarted during development

class FailsLibrary {
  static final Map<String, Fails> errors = {
    'NoNetwork' : Fails(
      code: 11,
      codeName: 'Network_Not_Available',
      info: 'Oops, Seems like you\'re not connected to the Internet'
    ),
    'SlowNetwork' : Fails(
      code: 12,
      codeName: 'Network_Speed_Very_Low',
      info: 'Seems like you have a slow connection, we are still collecting data'
    ),
    'ServerDown' : Fails(
        code: 20,
        codeName: 'Server_Down',
        info: 'Well it Looks like the server is sleeping'
    ),
    'BadRequest' : Fails(
      code: 69,
      codeName: 'Bad_Request',
      info: 'The request format was incorrect'
    ),
    'ServerError' : Fails(
        code: 101,
        codeName: 'Internal_Server_error',
        info: 'An internal server error occurred - '
    ),
    'Unknown' : Fails(
        code: 44,
        codeName: 'Unknown_Error',
        info: 'Something unexpected just happened, please consider'
            ' taking a screenshot and send it to us'
    )
  };

}