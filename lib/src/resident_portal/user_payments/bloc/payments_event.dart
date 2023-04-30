part of 'payments_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentStart extends PaymentEvent {}

class PaymentCreateIntent extends PaymentEvent {
  const PaymentCreateIntent({
    required this.billingDetails,
    required this.rentBill,
  });
  final BillingDetails billingDetails;
  final String rentBill;

  @override
  List<Object> get props => [billingDetails, rentBill];
}

class PaymentConfirmIntent extends PaymentEvent {
  const PaymentConfirmIntent({required this.clientSecret});

  final String clientSecret;

  @override
  List<Object> get props => [clientSecret];
}
