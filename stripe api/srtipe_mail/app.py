from flask import Flask, request, jsonify, redirect, render_template
import stripe
from flask_mail import Mail, Message
import datetime

app = Flask(__name__, static_url_path="", static_folder="public")

# Stripe configuration
stripe.api_key = "sk_test_51PX3AWRo7edOoAU9mTe3shOEl3v9hEERW07fvXs4HieusRJ8xg597wsTBic9UYU5zB2ezg7tGOxFrZEfaKAAuHF900ZNiz5E16"
LOCAL_DOMAIN = "http://localhost:4242"
endpoint_secret = 'whsec_836640342177dac3c5ad49e3de212244deb6f90a7c669b7abb436f5a2ff5f8f4'

# Flask-Mail configuration
app.config['SECRET_KEY'] = "1dfvrthhtbtytyjyj" # Random key
app.config['MAIL_SERVER'] = "smtp.googlemail.com" # SMTP server
app.config['MAIL_PORT'] = 587 # SMTP port
app.config['MAIL_USE_TLS'] = True # For security
app.config['MAIL_USERNAME'] = "aselarohana0522@gmail.com" # Email address
app.config['MAIL_PASSWORD'] = '" # Use an App Password instead of your actual password

mail = Mail(app)

# Stripe Checkout session route
@app.route("/create-checkout-session", methods=["GET"])
def create_checkout_session():
    session = stripe.checkout.Session.create(
        payment_method_types=["card"],
        line_items=[{
            "price_data": {
                "currency": "usd",
                "product_data": {
                    "name": "Bus Ticket",
                },
                "unit_amount": 1000,
            },
            "quantity": 1,
        }],
        mode="payment",
        success_url=LOCAL_DOMAIN + "/payment/success?session_id={CHECKOUT_SESSION_ID}",
        cancel_url=LOCAL_DOMAIN + "/payment/cancel",
    )
    return redirect(session.url, code=303)

# Webhook to listen for Stripe events
@app.route('/webhook', methods=['POST'])
def webhook():
    global customer_name
    payload = request.data
    sig_header = request.headers['STRIPE_SIGNATURE']

    try:
        event = stripe.Webhook.construct_event(payload, sig_header, endpoint_secret)
    except ValueError:
        return jsonify({"error": "Invalid payload"}), 400
    except stripe.error.SignatureVerificationError:
        return jsonify({"error": "Invalid signature"}), 400

    if event['type'] == 'checkout.session.completed':
        print("Payment was successful")
        session = event['data']['object']
        customer_email = session.get("customer_details").get("email")
        customer_name = session.get("customer_details").get("name")
        
        
        # Send the bus ticket email
        send_bus_ticket_email(customer_email)

    return jsonify(success=True)

# Function to send bus ticket email
def send_bus_ticket_email(email):
    msg_title = "Your Bus Ticket"
    sender = "aselarohana0522@gmail.com"
    msg = Message(msg_title, sender=sender, recipients=[email])

    msg_body = "Thank you for using Rootx. Below is your ticket information:"
    data = {
        'app_name': "Rootx",
        'title': msg_title,
        'body': msg_body,
        'bus_route': "Colombo to Kandy",
        'bus_number': "NB-1234",
        'passenger_name': customer_name,
        'seat_number': "A1",
        'date': datetime.datetime.now().strftime("%Y-%m-%d"),
        'time': datetime.datetime.now().strftime("%H:%M:%S"),
        'price': "1000.00LKR",
        'Contact': "0771234567",
        'address': "No. 123, Galle Road, Colombo 03",
        'website': "https://www.rootx.lk",
        'facebook': "https://www.facebook.com/rootx",
        'twitter': "https://www.twitter.com/rootx",
        'instagram': "https://www.instagram",
        'youtube': "https://www.youtube.com/rootx",
        'footer': "Thank you for using Rootx. Safe journey!"
    }

    msg.html = render_template("email.html", data=data)

    try:
        mail.send(msg)
        print(f"Email sent to {email}")
    except Exception as e:
        print(f"The email was not sent due to {e}")

if __name__ == "__main__":
    app.run(debug=True, port=4242)
