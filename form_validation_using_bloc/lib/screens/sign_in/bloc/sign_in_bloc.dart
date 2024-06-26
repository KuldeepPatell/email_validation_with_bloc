import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation_using_bloc/screens/sign_in/bloc/sign_in_event.dart';
import 'package:form_validation_using_bloc/screens/sign_in/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInTextChangedEvent>(
      (event, emit) {
        if (EmailValidator.validate(event.emailValue) == false) {
          emit(SignInErrorState("Please enter a valid email address"));
        } else if (event.passwordValue.length < 8) {
          emit(SignInErrorState("please enter a valid password"));
        } else {
          emit(SignInValidState());
        }
      },
    );
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
