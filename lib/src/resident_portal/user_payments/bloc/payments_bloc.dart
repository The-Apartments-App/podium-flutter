import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<PaymentStart>(_onPaymentStart);
    on<PaymentCreateIntent>(_onPaymentCreateIntent);
    on<PaymentConfirmIntent>(_onPaymentConfirmIntent);
  }

  void _onPaymentStart(
    PaymentStart event,
    Emitter<PaymentState> emit,
  ) {
    emit(state.copyWith(status: PaymentStatus.initial));
  }

  Future<void> _onPaymentCreateIntent(
    PaymentCreateIntent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));

    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: event.billingDetails,
        ),
      ),
    );

    final paymentIntentResults = await _callPayEndpointMethodId(
      useStripeSdk: true,
      paymentMethodId: paymentMethod.id,
      currency: 'usd',
      rentBill: event.rentBill,
    );

    if (paymentIntentResults['error'] != null) {
      emit(state.copyWith(status: PaymentStatus.failure));
    }

    if (paymentIntentResults['clientSecret'] != null &&
        paymentIntentResults['requriesAction'] == null) {
      emit(state.copyWith(status: PaymentStatus.success));
    }
    if (paymentIntentResults['clientSecret'] != null &&
        paymentIntentResults['requriesAction'] == true) {
      final clientSecret = paymentIntentResults['clientSecret'] as String;
      add(PaymentConfirmIntent(clientSecret: clientSecret));
    }
  }

  Future<void> _onPaymentConfirmIntent(
    PaymentConfirmIntent event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      final paymentIntent =
          await Stripe.instance.handleNextAction(event.clientSecret);
      if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
        final results =
            await _callPayEndpointIntent(paymentIntentId: paymentIntent.id);
        if (results['error'] != null) {
          emit(state.copyWith(status: PaymentStatus.failure));
        } else {
          emit(state.copyWith(status: PaymentStatus.success));
        }
      }
    } catch (e) {
      debugPrint('error: $e');
      emit(state.copyWith(status: PaymentStatus.failure));
    }
  }

  Future<Map<String, dynamic>> _callPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    required String? rentBill,
  }) async {
    final url = Uri.parse(
      'https://us-central1-podium-78b4e.cloudfunctions.net/StripePayEndpointMethodId',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'useStripeSdk': useStripeSdk,
        'paymentMethodId': paymentMethodId,
        'currency': currency,
        'rentBill': rentBill,
      }),
    );
    return json.decode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _callPayEndpointIntent({
    required String paymentIntentId,
  }) async {
    final url = Uri.parse(
      'https://us-central1-podium-78b4e.cloudfunctions.net/StripePayEndpointIntentId',
    );
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'paymentIntentId': paymentIntentId,
      }),
    );
    return json.decode(response.body) as Map<String, dynamic>;
  }
}
