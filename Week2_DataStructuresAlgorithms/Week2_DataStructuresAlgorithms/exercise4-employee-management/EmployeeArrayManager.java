import java.util.Arrays;

/**
 * Array-backed store for Employee records.
 *
 * Arrays store elements in one contiguous block of memory, so any index
 * can be reached directly via (base address + index * element size) — O(1)
 * indexed access with excellent cache locality. The trade-off is a fixed
 * capacity: growing past it means allocating a new, bigger array and
 * copying every existing element over, an O(n) operation.
 *
 * This also explains the cost profile below: insertion at the end is cheap,
 * but search, traversal, and deletion are all O(n) because, unlike a
 * HashMap, there's no direct index from employeeId to array position.
 */
public class EmployeeArrayManager {

    private Employee[] employees;
    private int size = 0;

    public EmployeeArrayManager(int capacity) {
        employees = new Employee[capacity];
    }

    /** O(1) amortized; an occasional resize costs O(n). */
    public boolean add(Employee employee) {
        if (size == employees.length) {
            employees = Arrays.copyOf(employees, employees.length * 2);
        }
        employees[size++] = employee;
        return true;
    }

    /** O(n) — no index by id, so every element may need to be checked. */
    public Employee search(int employeeId) {
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId() == employeeId) {
                return employees[i];
            }
        }
        return null;
    }

    /** O(n) — visits every element exactly once. */
    public void traverse() {
        for (int i = 0; i < size; i++) {
            System.out.println(employees[i]);
        }
    }

    /** O(n) — find the element (O(n)), then shift everything after it left (O(n)). */
    public boolean delete(int employeeId) {
        for (int i = 0; i < size; i++) {
            if (employees[i].getEmployeeId() == employeeId) {
                for (int j = i; j < size - 1; j++) {
                    employees[j] = employees[j + 1];
                }
                employees[--size] = null;
                return true;
            }
        }
        return false;
    }
}
