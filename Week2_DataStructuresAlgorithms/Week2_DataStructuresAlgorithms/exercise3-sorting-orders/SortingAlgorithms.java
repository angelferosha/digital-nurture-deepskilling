/**
 * Bubble Sort: O(n^2) average/worst case; O(n) best case when the early-exit
 *              flag lets it stop after a single pass over already-sorted data.
 *              Simple to write, but impractical once n gets into the
 *              thousands because of the quadratic growth.
 *
 * Quick Sort:  O(n log n) average case; O(n^2) worst case (e.g. already-sorted
 *              or reverse-sorted input with a poor pivot choice — the
 *              last-element pivot used here is a known weak spot for that).
 *              In practice Quick Sort beats Bubble Sort by a wide margin on
 *              large datasets because of better cache locality and a much
 *              smaller constant factor, even though their worst cases are
 *              both technically quadratic.
 *
 * This is why Quick Sort (or a hybrid like Java's own Dual-Pivot Quicksort
 * for primitives) is the default choice for sorting large order lists,
 * while Bubble Sort is mainly useful as a teaching example.
 */
public class SortingAlgorithms {

    /** O(n^2) comparisons/swaps in the worst case. */
    public static void bubbleSort(Order[] orders) {
        int n = orders.length;
        boolean swapped;
        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - 1 - i; j++) {
                if (orders[j].getTotalPrice() > orders[j + 1].getTotalPrice()) {
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                    swapped = true;
                }
            }
            if (!swapped) break; // already sorted, stop early
        }
    }

    /** O(n log n) average. Lomuto partition scheme, pivot = last element. */
    public static void quickSort(Order[] orders, int low, int high) {
        if (low < high) {
            int pivotIndex = partition(orders, low, high);
            quickSort(orders, low, pivotIndex - 1);
            quickSort(orders, pivotIndex + 1, high);
        }
    }

    private static int partition(Order[] orders, int low, int high) {
        double pivot = orders[high].getTotalPrice();
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (orders[j].getTotalPrice() <= pivot) {
                i++;
                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }
        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;

        return i + 1;
    }
}
