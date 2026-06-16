public class Main {
    public static void main(String[] args) {
        EmployeeArrayManager manager = new EmployeeArrayManager(4);

        manager.add(new Employee(1, "Nina Patel", "Engineer", 85000));
        manager.add(new Employee(2, "Tom Reyes", "Designer", 72000));
        manager.add(new Employee(3, "Lena Schmidt", "Manager", 98000));

        System.out.println("All employees:");
        manager.traverse();

        System.out.println("\nSearch for id=2: " + manager.search(2));

        manager.delete(2);
        System.out.println("\nAfter deleting id=2:");
        manager.traverse();
    }
}
