package com.library.repository;

import java.util.ArrayList;
import java.util.List;

public class BookRepository {

    private final List<String> books = new ArrayList<>();

    public BookRepository() {
        books.add("Clean Code");
        books.add("Effective Java");
    }

    public void addBook(String title) {
        books.add(title);
        System.out.println("Book added to repository: " + title);
    }

    public List<String> findAllBooks() {
        return books;
    }
}
