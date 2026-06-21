package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    // Not wired yet -- this exercise only sets up the Spring context.
    // Dependency injection is added in Exercise 2.
    private BookRepository bookRepository;

    public void addBook(String title) {
        if (bookRepository == null) {
            System.out.println("BookRepository is not wired yet (see Exercise 2 for dependency injection).");
            return;
        }
        bookRepository.addBook(title);
    }

    public void listBooks() {
        if (bookRepository == null) {
            System.out.println("BookRepository is not wired yet (see Exercise 2 for dependency injection).");
            return;
        }
        bookRepository.findAllBooks().forEach(System.out::println);
    }
}
