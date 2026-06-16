import java.util.HashMap;
import java.util.Map;

/**
 * Inventory store backed by a HashMap<Integer, Product>.
 *
 * Why a HashMap instead of an ArrayList here?
 *   - Products are looked up, updated, and deleted by productId far more
 *     often than the inventory is iterated in a particular order.
 *   - A HashMap gives O(1) average-case add/update/delete/lookup by key.
 *     An ArrayList would need an O(n) linear scan to find the matching id
 *     for every one of those operations.
 *   - The trade-off is that a HashMap doesn't preserve insertion order.
 *     If "list products in the order they were added" mattered, a
 *     LinkedHashMap would give the same O(1) operations while keeping
 *     order. If "list products sorted by id/price" mattered, a TreeMap
 *     would trade O(1) for O(log n) operations in exchange for sorted
 *     iteration.
 */
public class InventoryManagement {

    private final Map<Integer, Product> inventory = new HashMap<>();

    /** O(1) average — HashMap insertion. */
    public boolean addProduct(Product product) {
        if (inventory.containsKey(product.getProductId())) {
            System.out.println("Product ID already exists: " + product.getProductId());
            return false;
        }
        inventory.put(product.getProductId(), product);
        return true;
    }

    /** O(1) average — HashMap lookup, then in-place field mutation. */
    public boolean updateProduct(int productId, String name, Integer quantity, Double price) {
        Product product = inventory.get(productId);
        if (product == null) return false;
        if (name != null) product.setProductName(name);
        if (quantity != null) product.setQuantity(quantity);
        if (price != null) product.setPrice(price);
        return true;
    }

    /** O(1) average — HashMap removal. */
    public boolean deleteProduct(int productId) {
        return inventory.remove(productId) != null;
    }

    /** O(1) average — HashMap lookup. */
    public Product getProduct(int productId) {
        return inventory.get(productId);
    }

    /** O(n) — every operation that visits all products is necessarily linear. */
    public void displayAll() {
        inventory.values().forEach(System.out::println);
    }
}
