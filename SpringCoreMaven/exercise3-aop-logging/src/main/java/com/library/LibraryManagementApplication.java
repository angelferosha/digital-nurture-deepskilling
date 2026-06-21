package com.library;

import com.library.service.BookService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class LibraryManagementApplication {

    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        BookService bookService = (BookService) context.getBean("bookService");

        // Each call below is wrapped by LoggingAspect -- watch the console
        // for "... executed in N ms" messages.
        bookService.addBook("Refactoring");
        bookService.listBooks();
    }
}
