package com.library.repository;

import com.library.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;

// Spring Data JPA generates the implementation at runtime --
// findAll(), findById(), save(), deleteById(), etc. all come for free.
public interface BookRepository extends JpaRepository<Book, Long> {
}
