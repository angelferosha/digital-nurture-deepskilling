import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        Order[] bubbleOrders = {
            new Order(1, "Alice", 250.00),
            new Order(2, "Bob", 75.50),
            new Order(3, "Carol", 430.25),
            new Order(4, "Dave", 12.99),
            new Order(5, "Eve", 199.99)
        };
        Order[] quickOrders = bubbleOrders.clone();

        SortingAlgorithms.bubbleSort(bubbleOrders);
        System.out.println("Bubble sorted: " + Arrays.toString(bubbleOrders));

        SortingAlgorithms.quickSort(quickOrders, 0, quickOrders.length - 1);
        System.out.println("Quick sorted:  " + Arrays.toString(quickOrders));
    }
}
