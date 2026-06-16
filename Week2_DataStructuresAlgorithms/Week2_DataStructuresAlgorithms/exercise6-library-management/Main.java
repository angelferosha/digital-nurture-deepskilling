import java.util.Arrays;
import java.util.Comparator;

public class Main {
    public static void main(String[] args) {
        Book[] books = {
            new Book(1, "Clean Code", "Robert Martin"),
            new Book(2, "The Pragmatic Programmer", "Andrew Hunt"),
            new Book(3, "Design Patterns", "Erich Gamma"),
            new Book(4, "Refactoring", "Martin Fowler")
        };

        System.out.println("Linear search for 'Design Patterns':");
        System.out.println(LibrarySearch.linearSearchByTitle(books, "Design Patterns"));

        Book[] sorted = books.clone();
        Arrays.sort(sorted, Comparator.comparing(Book::getTitle));

        System.out.println("\nBinary search for 'Refactoring' (on sorted array):");
        System.out.println(LibrarySearch.binarySearchByTitle(sorted, "Refactoring"));
    }
}
