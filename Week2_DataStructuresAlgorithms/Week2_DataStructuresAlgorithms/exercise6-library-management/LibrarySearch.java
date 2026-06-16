/**
 * Linear search:  O(n). Works on the catalog in any order, including one
 *                 that's frequently added to, so no maintenance cost.
 *
 * Binary search:  O(log n), but the catalog must be sorted by title first.
 *                 For a library catalog — sorted once, then searched
 *                 thousands of times by patrons — that one-time sort pays
 *                 for itself many times over as the collection grows.
 *                 For a small or constantly-churning list (e.g. a
 *                 "recently added" shelf), the overhead of keeping it
 *                 sorted may not be worth it, and linear search is simpler.
 */
public class LibrarySearch {

    public static Book linearSearchByTitle(Book[] books, String title) {
        for (Book b : books) {
            if (b.getTitle().equalsIgnoreCase(title)) return b;
        }
        return null;
    }

    /** sortedBooks must already be sorted by title (ascending). */
    public static Book binarySearchByTitle(Book[] sortedBooks, String title) {
        int low = 0, high = sortedBooks.length - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int cmp = sortedBooks[mid].getTitle().compareToIgnoreCase(title);
            if (cmp == 0) return sortedBooks[mid];
            else if (cmp < 0) low = mid + 1;
            else high = mid - 1;
        }
        return null;
    }
}
