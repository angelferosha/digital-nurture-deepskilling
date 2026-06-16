public class StripeAdapter implements PaymentProcessor {
    private StripeGateway stripeGateway = new StripeGateway();

    public void processPayment(double amount) {
        stripeGateway.sendPayment(amount);
    }
}
