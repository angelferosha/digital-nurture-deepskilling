import java.util.Arrays;
import java.util.Comparator;

public class Main {
    public static void main(String[] args) {
        Product[] products = {
            new Product(1, "Bluetooth Speaker", "Electronics"),
            new Product(2, "Yoga Mat", "Fitness"),
            new Product(3, "Air Fryer", "Kitchen"),
            new Product(4, "Desk Lamp", "Home"),
            new Product(5, "Running Shoes", "Footwear")
        };

        System.out.println("Linear search for 'Air Fryer':");
        System.out.println(SearchAlgorithms.linearSearch(products, "Air Fryer"));

        Product[] sorted = products.clone();
        Arrays.sort(sorted, Comparator.comparing(Product::getProductName));

        System.out.println("\nBinary search for 'Desk Lamp' (on sorted array):");
        System.out.println(SearchAlgorithms.binarySearch(sorted, "Desk Lamp"));
    }
}
