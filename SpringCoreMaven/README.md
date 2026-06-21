# Spring Core & Maven — Library Management Exercises

Nine progressively-building exercises, each a complete, standalone Maven project,
all centered on a "LibraryManagement" application — starting from a bare Spring XML
config and ending with a full Spring Boot REST API.

## Building & running

Each exercise folder is a self-contained Maven project. From inside any folder:

```bash
mvn clean compile exec:java -Dexec.mainClass="com.library.LibraryManagementApplication"
```

or simpler, if you're using an IDE (IntelliJ / Eclipse / VS Code): import the folder
as a Maven project and run `LibraryManagementApplication.main()` directly.

Exercise 9 is a Spring Boot app, so it's run differently:

```bash
cd exercise9-spring-boot-app
mvn spring-boot:run
```

> **Note:** these projects weren't compiled in the environment that generated them
> (no Maven Central access there), so they haven't been build-verified end-to-end.
> The code follows standard, well-established Spring/Maven patterns and has been
> reviewed carefully for syntax — but run `mvn clean compile` yourself as a first
> step, and let me know if anything needs adjusting.

---

## Exercise 1: Configuring a Basic Spring Application

**Folder:** `exercise1-basic-spring-application`

Sets up the project skeleton: `pom.xml` with the Spring Core (`spring-context`)
dependency, `applicationContext.xml` declaring `bookRepository` and `bookService`
beans, the `BookService`/`BookRepository` classes, and a `LibraryManagementApplication`
main class that loads the context and fetches the `bookService` bean.

At this stage the beans exist but aren't wired together yet — `BookService` calls
print a friendly message rather than throwing a `NullPointerException` if you run it,
since dependency injection isn't introduced until Exercise 2.

---

## Exercise 2: Implementing Dependency Injection

**Folder:** `exercise2-dependency-injection`

`applicationContext.xml` now wires `bookRepository` into `bookService` with
`<property name="bookRepository" ref="bookRepository"/>` (setter injection), and
`BookService` gets the `setBookRepository(...)` method Spring needs to perform that
wiring. The main class calls `addBook(...)` and `listBooks()` to prove the injected
repository is actually being used.

---

## Exercise 3: Implementing Logging with Spring AOP

**Folder:** `exercise3-aop-logging`

Adds `spring-aop` + `aspectjweaver` to `pom.xml`, a `LoggingAspect` class
(`com.library.aspect`) using an `@Around` advice to time every method call on
`com.library.service.*`, and `<aop:aspectj-autoproxy/>` in `applicationContext.xml`
to activate annotation-driven aspects. Running the main class prints an
"... executed in N ms" line around each `bookService` call.

---

## Exercise 4: Creating and Configuring a Maven Project

**Folder:** `exercise4-maven-project-setup`

Just a `pom.xml` — the exercise is specifically about Maven project setup. Includes
`spring-context`, `spring-aop`, and `spring-webmvc` dependencies, plus an explicit
`maven-compiler-plugin` configuration pinned to Java 1.8 (as opposed to setting
`maven.compiler.source`/`target` properties directly, which the other exercises use —
both approaches are shown across the repo since either is valid).

---

## Exercise 5: Configuring the Spring IoC Container

**Folder:** `exercise5-ioc-container`

Functionally the same end state as Exercise 2 (central `applicationContext.xml`
defining and wiring both beans, `BookService` with a setter, a main class to verify
it), reframed around the idea of the IoC container as the single source of truth for
bean configuration.

---

## Exercise 6: Configuring Beans with Annotations

**Folder:** `exercise6-annotation-config`

Replaces explicit `<bean>` declarations with `<context:component-scan
base-package="com.library"/>` plus `@Service` on `BookService` and `@Repository` on
`BookRepository`. `BookService` is now wired via constructor injection with
`@Autowired`, which Spring auto-detects.

---

## Exercise 7: Implementing Constructor and Setter Injection

**Folder:** `exercise7-constructor-setter-injection`

`BookService` has both a constructor and a `setBookRepository(...)` setter.
`applicationContext.xml` wires it via `<constructor-arg ref="bookRepository"/>`, with
a commented-out `<property>`-based alternative shown for comparison (wiring the same
dependency both ways at once would just have the setter silently overwrite whatever
the constructor set, so only one is active at a time — the file's comments explain
why).

---

## Exercise 8: Implementing Basic AOP with Spring

**Folder:** `exercise8-basic-aop`

A second aspect example, this time using `@Before` and `@After` advice (rather than
Exercise 3's `@Around`) on `LoggingAspect`, to show logging both as the method starts
and as it finishes — separated entirely from `BookService`'s own code, which never
mentions logging at all.

---

## Exercise 9: Creating a Spring Boot Application

**Folder:** `exercise9-spring-boot-app`

A full Spring Boot rewrite: `spring-boot-starter-web`, `spring-boot-starter-data-jpa`,
and the H2 in-memory database, configured via `application.properties`. Includes a
`Book` JPA entity, a `BookRepository` interface (`extends JpaRepository<Book, Long>`
— Spring Data generates the implementation), and a `BookController` exposing full
CRUD at `/api/books` (`GET`, `GET /{id}`, `POST`, `PUT /{id}`, `DELETE /{id}`). The H2
console is enabled at `/h2-console` for poking at the database directly while the app
runs.

---

## Repo structure

```
.
├── exercise1-basic-spring-application/
├── exercise2-dependency-injection/
├── exercise3-aop-logging/
├── exercise4-maven-project-setup/
├── exercise5-ioc-container/
├── exercise6-annotation-config/
├── exercise7-constructor-setter-injection/
├── exercise8-basic-aop/
└── exercise9-spring-boot-app/
```
