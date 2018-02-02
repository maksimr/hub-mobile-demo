import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hub/components/screens/UserInfo.dart';
import 'package:hub/components/ui/Div.dart';
import 'package:hub/components/ui/Input.dart';
import 'package:hub/components/ui/LinkTextSpan.dart';
import 'package:hub/components/ui/PasswordInput.dart';
import 'package:hub/components/ui/PrimaryButton.dart';
import 'package:hub/i18n.dart';
import 'package:hub/resources/user.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Div(
      mainAxisAlignment: MainAxisAlignment.center,
      padding: new EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 2 * 8.0,
      ),
      children: [
        new _LoginLogo(),
        new _LoginTitle(),
        new _LoginForm(),
        new _LoginHint(),
      ],
    );
  }
}

class _LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 128.0,
      height: 128.0,
      child: new DecoratedBox(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.contain,
            image: new AssetImage('images/logo_Hub.png'),
          ),
        ),
      ),
    );
  }
}

class _LoginTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.only(top: 2 * 8.0),
      child: new Text(
        i18n('Log in to Hub'),
        style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _loginFormKey = new GlobalKey<FormState>();

  String _hubUrl = "http://localhost:8088/hub";
  String _username;
  String _password;
  String _error;

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _loginFormKey,
      child: new Div(
        padding: new EdgeInsets.only(top: 1 * 8.0),
        children: <Widget>[
          _buildHubUrl(),
          _buildUsernameInput(),
          _buildPasswordInput(),
          _buildErrorMessage(),
          _buildLoginButton(),
        ],
      ),
    );
  }

  _buildHubUrl() {
    return new Text(
      _hubUrl,
      style: new TextStyle(
        fontSize: 12.0,
        color: Colors.grey,
      ),
    );
  }

  _buildUsernameInput() {
    return new Input(
      placeholder: i18n('Username or Email*'),
      onSaved: (value) => _username = value,
      keyboardType: TextInputType.emailAddress,
    );
  }

  _buildPasswordInput() {
    return new PasswordInput(
      placeholder: i18n('Password*'),
      onSaved: (value) => _password = value,
    );
  }

  _buildLoginButton() {
    return new Padding(
      padding: new EdgeInsets.only(top: 3 * 8.0),
      child: new PrimaryButton(
        onPressed: _onSubmit,
        child: new Text(
          i18n('Login'),
          style: new TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _buildErrorMessage() {
    if (_error == null) return new Text("");

    return new Padding(
      padding: new EdgeInsets.only(top: 2 * 8.0),
      child: new Text(
        _error,
        style: new TextStyle(
          color: Colors.pink,
        ),
      ),
    );
  }

  _hideError() {
    setState(() => _error = null);
  }

  _onSubmit() {
    _hideError();

    final form = _loginFormKey.currentState;
    if (!form.validate()) return;

    form.save();
    _performLogin(_username, _password);
  }

  _performLogin(username, password) async {
    var data = await _performLoginByPassword(
      username: username,
      password: password,
      hubUrl: _hubUrl,
      clientId: '0-0-0-0-0',
      clientSecret: '6JW6SlqzFltF',
      scope: 'Hub',
    );

    if (data["error"] != null) {
      setState(() => _error = data["error_description"]);
      return;
    }

    var userInfo = await user(
      hubUrl: _hubUrl,
      accessToken: data["access_token"],
      id: 'me',
      fields: 'id,name,profile/avatar/url',
    );

    _onLogin(userInfo);
  }

  _onLogin(userInfo) {
    return Navigator.of(context).push(
          new MaterialPageRoute<Null>(
            builder: (BuildContext context) => new UserInfo(userInfo),
          ),
        );
  }

  _performLoginByPassword({
    username,
    password,
    hubUrl,
    clientId,
    clientSecret,
    scope,
  }) async {
    final credentials = BASE64.encode(UTF8.encode("$clientId:$clientSecret"));
    final request = (await (new HttpClient())
        .postUrl(Uri.parse("$hubUrl/api/rest/oauth2/token")));

    request.headers
      ..set(HttpHeaders.ACCEPT, "application/json, text/plain, */*")
      ..set(HttpHeaders.AUTHORIZATION, "Basic $credentials")
      ..set(HttpHeaders.CONTENT_TYPE, "application/x-www-form-urlencoded");

    request.write([
      "grant_type=password",
      "&access_type=offline",
      "&username=${Uri.encodeComponent(username)}",
      "&password=${Uri.encodeComponent(password)}",
      "&scope=$scope"
    ].join(''));

    final response = await request.close();

    final data = await response.transform(UTF8.decoder).join();
    return JSON.decode(data);
  }
}

class _LoginHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.only(top: 3 * 8.0),
      child: new RichText(
        textAlign: TextAlign.center,
        text: new TextSpan(
          children: [
            _privacyPolicyText(),
            _blankLine(),
            _hintText(),
          ],
          style: new TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  _blankLine() {
    return new TextSpan(text: '\n\n');
  }

  _hintText() {
    return new TextSpan(
      text: i18n(
          "You can also log in with your credentials for JetBrains Account or Active Directory (Domain) Labs "),
    );
  }

  _privacyPolicyText() {
    return new TextSpan(
      children: [
        new TextSpan(text: i18n("By logging in, you agree to the ")),
        new LinkTextSpan(
          text: i18n("Privacy Policy"),
          url: "https://www.jetbrains.com/company/privacy.html",
          style: new TextStyle(
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
