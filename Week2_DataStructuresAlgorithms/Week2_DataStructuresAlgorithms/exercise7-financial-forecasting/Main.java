import java.util.HashMap;

public class Main {
    public static void main(String[] args) {
        double principal = 10000;
        double growthRate = 0.07;
        int years = 10;

        System.out.printf("Recursive:    %.2f%n",
                FinancialForecast.futureValueRecursive(principal, growthRate, years));
        System.out.printf("Iterative:    %.2f%n",
                FinancialForecast.futureValueIterative(principal, growthRate, years));
        System.out.printf("Closed-form:  %.2f%n",
                FinancialForecast.futureValueClosedForm(principal, growthRate, years));
        System.out.printf("Memoized:     %.2f%n",
                FinancialForecast.futureValueMemoized(principal, growthRate, years, new HashMap<>()));
    }
}
