import java.util.Map;

/**
 * Predicts a future value by compounding a growth rate over a number of
 * periods: futureValue(P, r, n) = P * (1 + r)^n, expressed recursively as
 * futureValue(P, r, n) = futureValue(P, r, n-1) * (1 + r).
 *
 * Naive recursion: O(n) time (one call per year, O(1) work each) and O(n)
 *   space for the call stack. This particular recursion has no overlapping
 *   subproblems — each year is computed exactly once — so there's nothing
 *   to cache. The memoized version below is included anyway to demonstrate
 *   the general technique, which becomes essential for recursions that DO
 *   recompute the same subproblem repeatedly (e.g. Fibonacci-style models).
 *
 * Optimizing away the "excessive computation" the exercise asks about means
 * recognizing when recursion is the wrong tool: an iterative loop computes
 * the same result in O(n) time but O(1) space (no growing call stack), and
 * a closed-form power calculation gets it down to O(1) time outright.
 */
public class FinancialForecast {

    /** Pure recursion. O(n) time, O(n) call-stack space. */
    public static double futureValueRecursive(double principal, double growthRate, int years) {
        if (years == 0) return principal;
        return futureValueRecursive(principal, growthRate, years - 1) * (1 + growthRate);
    }

    /** Iterative version: same result, O(n) time, O(1) space. */
    public static double futureValueIterative(double principal, double growthRate, int years) {
        double value = principal;
        for (int i = 0; i < years; i++) {
            value *= (1 + growthRate);
        }
        return value;
    }

    /** Closed-form version: O(1) time using exponentiation. */
    public static double futureValueClosedForm(double principal, double growthRate, int years) {
        return principal * Math.pow(1 + growthRate, years);
    }

    /**
     * Memoized recursion. For THIS problem it offers no benefit over plain
     * recursion since each year is only ever computed once anyway — it's
     * included to show the pattern for recursions with overlapping
     * subproblems, where caching avoids exponential blow-up.
     */
    public static double futureValueMemoized(double principal, double growthRate, int years,
                                               Map<Integer, Double> cache) {
        if (years == 0) return principal;
        if (cache.containsKey(years)) return cache.get(years);
        double result = futureValueMemoized(principal, growthRate, years - 1, cache) * (1 + growthRate);
        cache.put(years, result);
        return result;
    }
}
