public class AdapterTest {
    public static void main(String[] args) {
        PaymentProcessor processor1 = new PayPalAdapter();
        processor1.processPayment(100.0);

        PaymentProcessor processor2 = new StripeAdapter();
        processor2.processPayment(250.0);
    }
}
