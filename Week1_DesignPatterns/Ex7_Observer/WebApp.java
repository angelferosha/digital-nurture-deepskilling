public class WebApp implements Observer {
    public void update(double price) {
        System.out.println("Web App: Stock price updated to " + price);
    }
}
