# Data Structures & Algorithms — Hands-On Exercises

Java solutions for 7 hands-on exercises covering hash maps, search algorithms, sorting,
arrays, linked lists, and recursion. Each exercise is a standalone, runnable folder.

## Running any exercise

```bash
cd exercise1-inventory-management
javac *.java
java Main
```

No external dependencies — plain Java (tested on JDK 21, compatible with JDK 8+).

---

## Exercise 1: Inventory Management System

**Folder:** `exercise1-inventory-management`

**Why data structures/algorithms matter here:** a warehouse inventory is queried,
updated, and modified constantly. The choice of data structure determines whether
those operations scale linearly with catalog size or stay roughly constant. A poor
choice (e.g. scanning a list to find a product by ID) turns a 10,000-SKU warehouse
into a system where every update takes noticeably longer than it should.

**Data structure choice:** a `HashMap<Integer, Product>` keyed by `productId` is used
instead of an `ArrayList`. Products are looked up by ID far more often than they're
iterated in a specific order, so the O(1) average-case add/update/delete/lookup of a
hash map outweighs an ArrayList's O(n) linear scan for the same operations. The
trade-off is no guaranteed iteration order — if that mattered, a `LinkedHashMap`
(insertion order) or `TreeMap` (sorted order, O(log n) operations) would be the
alternative.

**Complexity summary:**

| Operation | HashMap | ArrayList (for comparison) |
|---|---|---|
| Add | O(1) avg | O(1) amortized (end), O(n) (by id) |
| Update by id | O(1) avg | O(n) |
| Delete by id | O(1) avg | O(n) |
| List all | O(n) | O(n) |

---

## Exercise 2: E-commerce Platform Search Function

**Folder:** `exercise2-search-function`

**Big O notation:** Big O describes how an algorithm's running time (or memory) grows
as the input size `n` grows, ignoring constant factors and lower-order terms. It
answers "how does this scale?" rather than "how many milliseconds does this take?",
which makes it possible to compare algorithms independent of hardware.

**Best / average / worst case for search:**
- Linear search — best case O(1) (match is the first element), average and worst
  case O(n) (match is near the end, or absent).
- Binary search — best case O(1) (match is the middle element), average and worst
  case O(log n).

**Comparison & recommendation:** binary search is asymptotically faster, but it only
works on data that's sorted by the search key. For a platform's main product search,
maintaining a sorted index (or using a proper search index/database) and applying
binary search (or better, a hash-based or full-text index) is worth it because the
same catalog is searched far more often than it changes. For a small, frequently
changing list, linear search's simplicity may outweigh the sorting overhead.

---

## Exercise 3: Sorting Customer Orders

**Folder:** `exercise3-sorting-orders`

**Sorting algorithms overview:**
- **Bubble Sort** — repeatedly swaps adjacent out-of-order elements; simple but
  O(n²) average/worst case.
- **Insertion Sort** — builds a sorted prefix one element at a time by inserting each
  new element into its correct position; O(n²) average/worst case, but O(n) best case
  on nearly-sorted data, and efficient for small datasets.
- **Quick Sort** — partitions around a pivot and recursively sorts each side; O(n log n)
  average case, O(n²) worst case (e.g. a poor pivot on already-sorted input).
- **Merge Sort** — recursively splits the array in half, sorts each half, then merges;
  O(n log n) in all cases, at the cost of O(n) extra memory for the merge step.

**Bubble Sort vs Quick Sort performance:** Bubble Sort is O(n²) in virtually every
practical case; Quick Sort is O(n log n) on average. For 1,000 orders, that's roughly
1,000,000 operations for Bubble Sort versus roughly 10,000 for Quick Sort — a 100x
difference that only grows with the dataset.

**Why Quick Sort is generally preferred:** its average-case O(n log n) beats Bubble
Sort's O(n²) by a wide and growing margin, and in practice it also has better cache
locality and a smaller constant factor than other O(n log n) sorts like Merge Sort,
without Merge Sort's extra memory overhead. Bubble Sort's only real advantage is how
easy it is to explain, which is why it mostly survives as a teaching example.

---

## Exercise 4: Employee Management System

**Folder:** `exercise4-employee-management`

**Array representation in memory:** an array is a block of contiguous memory; element
`i` sits at `base_address + i * element_size`, which is why indexed access is O(1) —
the address is computed directly with no traversal. This contiguity also gives arrays
strong cache locality, since adjacent elements are likely to be loaded into the same
cache line.

**Limitations:** arrays have a fixed capacity at creation time. Growing past it means
allocating a brand-new array and copying every element over — O(n). Inserting or
deleting from the middle is also O(n) because every following element has to shift.
Arrays are the right choice when the size is known or changes rarely and indexed
access is the dominant operation; a resizable structure backed by a linked list, or a
self-resizing structure like an `ArrayList`/`Vector`, fits better when the collection
grows and shrinks often.

**Complexity summary:** add O(1) amortized, search O(n), traverse O(n), delete O(n)
(find the element, then shift everything after it left by one).

---

## Exercise 5: Task Management System

**Folder:** `exercise5-task-management`

**Linked list types:**
- **Singly Linked List** — each node holds a value and a pointer to the next node;
  traversal is one-directional.
- **Doubly Linked List** — each node also holds a pointer to the *previous* node,
  enabling backward traversal and O(1) removal of a node you already hold a reference
  to (no need to search for its predecessor), at the cost of extra memory per node.

**Why linked lists over arrays for dynamic data:** insertion at the head (or anywhere,
given a reference to the insertion point) is O(1) for a linked list because it's just
pointer rewiring — no shifting, no resizing. An array's insertion/deletion in the
middle costs O(n) because subsequent elements must shift, and growing past capacity
requires a full O(n) copy. The trade-off is that linked lists give up O(1) indexed
access — finding the nth element is O(n) since there's no arithmetic shortcut to a
node's memory address.

**Complexity summary:** add (at head) O(1), search O(n), traverse O(n), delete O(n)
(must find the node and its predecessor to unlink it).

---

## Exercise 6: Library Management System

**Folder:** `exercise6-library-management`

**Linear vs binary search:** linear search checks each book in turn until it finds a
match or exhausts the list — O(n), no ordering requirement. Binary search repeatedly
halves a *sorted* range — O(log n) — by comparing the middle element and discarding
the half that can't contain the target.

**Comparison & when to use each:** for a small catalog, or one that's reordered
constantly, the cost of keeping it sorted may outweigh binary search's benefit, so
linear search is simpler and fine. For a large, relatively stable catalog — which
describes most library systems — sorting once (O(n log n)) and then searching
repeatedly with binary search (O(log n) per query) is a clear win as the collection
and number of searches grow.

---

## Exercise 7: Financial Forecasting

**Folder:** `exercise7-financial-forecasting`

**Recursion:** a recursive algorithm solves a problem by calling itself on a smaller
version of the same problem until it reaches a base case simple enough to answer
directly. It can express problems with a naturally repeating structure — like
compounding a value year over year — more directly than an explicit loop, since each
call mirrors a single "step" of the underlying process.

**This algorithm's complexity:** `futureValue(P, r, n) = futureValue(P, r, n-1) * (1+r)`
makes exactly one recursive call per year, doing O(1) work each time, for O(n) time
overall and O(n) space on the call stack (one stack frame per year).

**Optimizing it:** this particular recursion has no overlapping subproblems — each
year is computed exactly once — so memoization (also demonstrated in the code, for
comparison) doesn't help here. What does help is recognizing recursion isn't the
right tool for a simple repeated multiplication: an iterative loop gets the same O(n)
time down to O(1) space by not growing a call stack, and a closed-form calculation
(`P * (1+r)^n` via `Math.pow`) gets the whole thing to O(1) time. Memoization becomes
essential instead for recursions that *do* recompute the same subproblem many times
(e.g. a forecast whose growth rate depends recursively on the two previous periods,
Fibonacci-style) — without it, such a recursion would be exponential.

---

## Repo structure

```
.
├── exercise1-inventory-management/
├── exercise2-search-function/
├── exercise3-sorting-orders/
├── exercise4-employee-management/
├── exercise5-task-management/
├── exercise6-library-management/
└── exercise7-financial-forecasting/
```
