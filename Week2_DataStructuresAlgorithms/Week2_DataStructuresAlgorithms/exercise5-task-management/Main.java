public class Main {
    public static void main(String[] args) {
        TaskLinkedList tasks = new TaskLinkedList();

        tasks.add(new Task(1, "Design schema", "Done"));
        tasks.add(new Task(2, "Build API", "In Progress"));
        tasks.add(new Task(3, "Write tests", "Pending"));

        System.out.println("All tasks:");
        tasks.traverse();

        System.out.println("\nSearch for id=2: " + tasks.search(2));

        tasks.delete(2);
        System.out.println("\nAfter deleting id=2:");
        tasks.traverse();
    }
}
