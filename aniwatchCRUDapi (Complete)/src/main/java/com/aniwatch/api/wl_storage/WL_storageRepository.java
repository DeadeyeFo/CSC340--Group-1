package com.aniwatch.api.wl_storage;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * WL_storageRepository is a Spring Data JPA repository interface for the WL_storage entity.
 * It provides methods to perform CRUD operations on WL_storage records in the database.
 * The interface extends JpaRepository, which provides built-in methods for database operations.
 */
public interface WL_storageRepository extends JpaRepository<WL_storage, Integer> {

}
