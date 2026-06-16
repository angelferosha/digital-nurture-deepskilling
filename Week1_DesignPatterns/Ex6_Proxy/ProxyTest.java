public class ProxyTest {
    public static void main(String[] args) {
        Image image = new ProxyImage("photo.jpg");

        System.out.println("Image object created, but not loaded yet.");

        image.display();
        image.display();
    }
}
