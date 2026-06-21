package com.library.service;

import com.library.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BookService {

    private final BookRepository bookRepository;

    // A class with a single constructor doesn't strictly need @Autowired
    // (Spring 4.3+ infers it), but it's included here to make the
    // dependency injection point explicit.
    @Autowired
    public BookService(BookRepository bookRepository) {
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
