package com.library.service;

import com.library.repository.BookRepository;

public class BookService {

    private BookRepository bookRepository;

    // Constructor injection
    public BookService(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    // Setter injection -- an alternative way to wire the same dependency.
    // See the commented-out bean definition in applicationContext.xml.
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void addBook(String title) {
        bookRepository.addBook(title);
    }

    public void listBooks() {
        System.out.println("Books in library:");
        bookRepository.findAllBooks().forEach(System.out::println);
    }
}
