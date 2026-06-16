/**
 * Linear search:  O(n) worst/average case; O(1) best case (match at index 0).
 *                 Works directly on unsorted data, no pre-processing needed.
 *
 * Binary search:  O(log n) worst/average case; O(1) best case (match at the
 *                 middle element). Requires the array to already be sorted
 *                 by the search key — sorting costs O(n log n) up front if
 *                 it isn't sorted yet, which only pays off if the same
 *                 sorted array will be searched many times.
 */
public class SearchAlgorithms {

    /** Scans every element until a match is found or the array is exhausted. */
    public static Product linearSearch(Product[] products, String targetName) {
        for (Product p : products) {
            if (p.getProductName().equalsIgnoreCase(targetName)) {
                return p;
            }
        }
        return null;
    }

    /** products must already be sorted by name (ascending). */
    public static Product binarySearch(Product[] sortedProducts, String targetName) {
        int low = 0, high = sortedProducts.length - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int cmp = sortedProducts[mid].getProductName().compareToIgnoreCase(targetName);

            if (cmp == 0) {
                return sortedProducts[mid];
            } else if (cmp < 0) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return null;
    }
}
