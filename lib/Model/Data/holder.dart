enum REQUEST_STATUS
{
  onHold,
  onSuccess,
  onFail
}

class OnCallRequest
{
  Function onHold, onSuccess, onFail;

  OnCallRequest({
    required this.onHold,
    required this.onSuccess,
    required this.onFail
  });
}

class RequestHolder<T>
{
  REQUEST_STATUS _request_status = REQUEST_STATUS.onHold;
  String _errorMessage = "";
  T? _value;

  REQUEST_STATUS get request_status => _request_status;
  String get errorMessage => _errorMessage;
  T? get value => _value;

  void setRequestStatus (REQUEST_STATUS request_status)
  {
    _request_status = request_status;
  }

  void setErrorMessage (String errMsg)
  {
    _errorMessage = errMsg;
  }

  void setValue (T val)
  {
    _value = val;
  }

}