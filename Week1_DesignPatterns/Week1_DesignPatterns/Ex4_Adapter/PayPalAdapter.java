public class PayPalAdapter implements PaymentProcessor {
    private PayPalGateway payPalGateway = new PayPalGateway();

    public void processPayment(double amount) {
        payPalGateway.makePayment(amount);
    }
}
