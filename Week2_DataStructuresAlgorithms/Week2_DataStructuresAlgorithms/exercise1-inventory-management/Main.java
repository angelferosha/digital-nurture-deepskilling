public class Main {
    public static void main(String[] args) {
        InventoryManagement inventory = new InventoryManagement();

        inventory.addProduct(new Product(101, "Wireless Mouse", 50, 19.99));
        inventory.addProduct(new Product(102, "Mechanical Keyboard", 30, 79.99));
        inventory.addProduct(new Product(103, "USB-C Hub", 75, 24.50));

        System.out.println("All products:");
        inventory.displayAll();

        inventory.updateProduct(102, null, 25, 74.99);
        System.out.println("\nAfter updating product 102:");
        System.out.println(inventory.getProduct(102));

        inventory.deleteProduct(101);
        System.out.println("\nAfter deleting product 101:");
        inventory.displayAll();
    }
}
