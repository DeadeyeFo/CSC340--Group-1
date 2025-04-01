package com.aniwatch.api.wl_storage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * WL_storageService is a service class that handles business logic related to the WL_storage entity.
 * It interacts with the WL_storageRepository to perform CRUD operations on WL_storage records.
 * Centralized place for business logic related to WL_storage.
 */
@Service
public class WL_storageService {

    @Autowired
    private WL_storageRepository wl_storageRepository;

    /**
     * Get all WL_storage records.
     * 
     * @return a list of all WL_storage records.
     */
    public Object getAllWL_storage() {
        return wl_storageRepository.findAll();
    }

    /**
     * Get a WL_storage record by id.
     * 
     * @param id the id of the WL_storage record.
     * @return the WL_storage record with the specified id.
     */
    public Object getWL_storageById(Integer id) {
        return wl_storageRepository.findById(id).orElse(null);
    }
}
