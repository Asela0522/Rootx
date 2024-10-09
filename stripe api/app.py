from flask import Flask, request, jsonify,redirect
import stripe

app = Flask(__name__,
            static_url_path="",
            static_folder="public")

stripe.api_key = "sk_test_51PX3AWRo7edOoAU9mTe3shOEl3v9hEERW07fvXs4HieusRJ8xg597wsTBic9UYU5zB2ezg7tGOxFrZEfaKAAuHF900ZNiz5E16"

LOCAL_DOMAIN = "http://localhost:4242"

@app.route("/create-checkout-session", methods=["GET"])
def create_checkout_session():
    session = stripe.checkout.Session.create(
        payment_method_types=["card"],
        line_items=[
            {
                "price_data": {
                    "currency": "usd",
                    "product_data": {
                        "name": "T-shirt",
                    },
                    "unit_amount": 2000,
                },
                "quantity": 1,
            },
        ],
        mode="payment",
        success_url=LOCAL_DOMAIN + "/payment/success?session_id={CHECKOUT_SESSION_ID}",
        cancel_url=LOCAL_DOMAIN + "/payment/cancel",
    )
    return redirect(session.url, code=303)

@app.route("/payment/success", methods=["GET"])
def payment_success():
    create_checkout_session =stripe.checkout.Session.retrieve(request.args.get("session_id"))

    Email = create_checkout_session.get("customer_details").get("email")
    status = create_checkout_session.get("payment_status")

    return jsonify({"message": "Payment success", "email": Email, "status": status})


@app.route("/payment/cancel", methods=["GET"])
def payment_cancel():
    return jsonify({"message": "Payment canceled"})



endpoint_secret = 'whsec_836640342177dac3c5ad49e3de212244deb6f90a7c669b7abb436f5a2ff5f8f4'

@app.route('/webhook', methods=['POST'])
def webhook():
    event = None
    payload = request.data
    sig_header = request.headers['STRIPE_SIGNATURE']

    try:
        event = stripe.Webhook.construct_event(
            payload, sig_header, endpoint_secret
        )
    except ValueError as e:
        # Invalid payload
        raise e
    except stripe.error.SignatureVerificationError as e:
        # Invalid signature
        raise e
    
    if event['type'] == 'payment_intent.succeeded':
    
      payment_intent = event['data']['object']
      print("session id",payment_intent)
    # ... handle other event types
    else:
      print('Unhandled event type {}'.format(event['type']))

    return jsonify(success=True)

if __name__ == "__main__":
    app.run(debug=True,port=4242)