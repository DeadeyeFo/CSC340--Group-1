package com.aniwatch.api.provider;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class providerData {
    @Autowired
    private providerRepository providerRepository;

    /**
     * Get all providers.
     *
     * @return The list of all provider.
     */
    public List<provider> getAllProviders() {
        return providerRepository.findAll();
    }

    /**
     * Get a provider.
     *
     * @param providerId A providers Id.
     * @return a provider object.
     */
    public provider getProviderByProviderId(int providerId) {
        return providerRepository.findById(Integer.valueOf(providerId)).orElse(null);
    }

    /**
     * Get all providers whose full bio matches the search term.
     *
     * @param bio the search key.
     * @return the list of matching providers.
     */
    public List<provider> getProviderByBio(String bio) {
        return providerRepository.getProviderByBio(bio);
    }

    /**
     * Get all providers with a name that contains the given string.
     *
     * @param username the search name
     * @return list of matching providers
     */
    public List<provider> getProviderByUsername(String username) {
        return providerRepository.getProviderByUsername(username);
    }

    /**
     * Add a new provider to the database.
     *
     * @param provider the new provider being added.
     */
    public void addNewProvider(provider provider) {
        providerRepository.save(provider);
    }

    /**
     * Update an existing providers data.
     *
     * @param providerId the providers ID.
     * @param provider the new providers details.
     */
    public void updateProvider(Integer providerId, provider provider) {
        provider existing = getProviderByProviderId(providerId);
        existing.setUsername(provider.getUsername());
        existing.setBio(provider.getBio());
        providerRepository.save(existing);
    }

    /**
     * Delete a provider.
     *
     * @param providerId the providers ID.
     */
    public void deleteProviderByProviderId(Integer providerId) {
        providerRepository.deleteById(providerId);
    }
}
